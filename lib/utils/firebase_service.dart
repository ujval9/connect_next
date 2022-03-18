import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'get_storage_service.dart';

getOrders() {
  final Stream<QuerySnapshot> ordersStream = FirebaseFirestore.instance
      .collection('orders')
      .where('status', isEqualTo: 'pending')
      .snapshots();
  return ordersStream;
}

Future<Map<String, String>> getSingleOrder(
    Map<String, dynamic> delivery) async {
  Map<String, dynamic> userData = {};
  var variable = await FirebaseFirestore.instance
      .collection('orders')
      .doc(delivery['order_id'].toString())
      .get();
  userData = variable.data() ?? {};
  Map<String, dynamic> sDMap = Map<String, dynamic>.from(userData);
  Map<String, String> stringQueryParameters = sDMap.map((key, value) {
    if (key == 'delivery_deadline') {
      return MapEntry(
          key, DateFormat('dd/MM/yyyy, hh:mm a').format(value.toDate()));
    } else {
      return MapEntry(key, value.toString());
    }
  });

  stringQueryParameters['delivery_status'] = delivery['status'];
  stringQueryParameters['delivery_updated_at'] =
      delivery['updated_at'].toDate().toString();
  stringQueryParameters['delivery_created_at'] =
      delivery['created_at'].toDate().toString();
  stringQueryParameters['order_id'] = delivery['order_id'];

  stringQueryParameters['delivery_id'] = delivery['id'];
  return stringQueryParameters;
}

getMyOrders([String value = '']) {
  List fStatus = ['1', '0'];
  if (value.isNotEmpty) {
    if (value == 'completed') {
      fStatus = ['2'];
    } else {
      fStatus = ['1', '0'];
    }
  }
  final Stream<QuerySnapshot> ordersStream = FirebaseFirestore.instance
      .collection('deliveries')
      .where('user_id', isEqualTo: getUid())
      .where('status', whereIn: fStatus)
      .snapshots();
  // FirebaseFirestore.instance.collection('orders').where('age', isGreaterThan: 20).snapshots();
  return ordersStream;
}

acceptOrder(String orderId, String userId) {
  DateTime currentPhoneDate = DateTime.now(); //DateTime

  Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

  CollectionReference deliveries =
      FirebaseFirestore.instance.collection('deliveries');
  CollectionReference order = FirebaseFirestore.instance.collection('orders');
  deliveries.add({
    'user_id': userId,
    'order_id': orderId,
    'status': '0',
    'created_at': myTimeStamp,
    'updated_at': myTimeStamp,
  }).then((value) {
    order.doc(orderId).update({'status': 'started'}).then((value) {
      EasyLoading.showSuccess('Great Success!');
      Get.offAllNamed('/master?index=1');
    }).catchError((error) {
      EasyLoading.showError('Error Occured ,Please Try Again');
    });
  }).catchError((error) {
    EasyLoading.showError('Error Occured ,Please Try Again');
  });
}

updateOrder(String orderId, String deliveryId, String status,
    String customerOtp) async {
  DateTime currentPhoneDate = DateTime.now(); //DateTime

  Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
  String orderCusOtp;
  String dbStatus = '0';
  CollectionReference deliveries =
      FirebaseFirestore.instance.collection('deliveries');
  CollectionReference order = FirebaseFirestore.instance.collection('orders');
  Map<String, dynamic> orderData = {};
  if (status == 'In Transit') {
    dbStatus = '1';
  } else if (status == 'completed') {
    if (customerOtp != '') {
      var variable = await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .get();
      orderData = variable.data() ?? {};
      Map<String, dynamic> sDMap = Map<String, dynamic>.from(orderData);
      Map<String, String> stringQueryParameters =
          sDMap.map((key, value) => MapEntry(key, value.toString()));
      orderCusOtp = stringQueryParameters['customer_otp'] ?? '0';

      if (customerOtp == orderCusOtp) {
        dbStatus = '2';
        CollectionReference payments =
            FirebaseFirestore.instance.collection('payments');
        payments.add({
          'user_id': getUid(),
          'delivery_id': deliveryId,
          'base_amount': stringQueryParameters['base_amount'] ?? '0',
          'final_amount': stringQueryParameters['base_amount'] ?? '0',
          'created_at': myTimeStamp,
          'updated_at': myTimeStamp,
          'ispaid': false,
        }).catchError((error) {
          EasyLoading.showError('Error Occured ,Please Try Again');
        });
      } else {
        EasyLoading.showError('Invalid OTP');
        return;
      }
    } else {
      EasyLoading.showError('Enter Customer OTP');
      return;
      // Get.previousRoute;
    }
  } else {
    dbStatus = '0';
  }

  deliveries
      .doc(deliveryId)
      .update({'status': dbStatus, 'updated_at': myTimeStamp}).then((value) {
    if (dbStatus == '2') {
      order.doc(orderId).update({'status': 'completed'}).then((value) {
        EasyLoading.showSuccess('Great Success!');
        Get.offAllNamed('/master?index=1');
      }).catchError((error) {
        EasyLoading.showError('Error Occured ,Please Try Again');
      });
    } else {
      EasyLoading.showSuccess('Great Success!');
      Get.offAllNamed('/master?index=1');
    }
  }).catchError((error) {
    EasyLoading.showError('Error Occured ,Please Try Again');
  });
}

signinwithemail(email, password) async {
  try {
    final authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (authResult.user != null) {
      EasyLoading.showSuccess('User Logged In Successfully!');
      var uid = authResult.user!.uid;
      var userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userData.data()!['is_active'] == '1') {
        saveUserLogin(uid, true);
        Get.offAllNamed('/master');
      } else {
        EasyLoading.showError('User not active,Please contact admin');
      }
    } else {
      EasyLoading.showError('Failed with Error');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'wrong-password') {
      EasyLoading.showError('Wrong Password Entered');
      print('Wrong Password Entered');
    } else {
      EasyLoading.showError(e.message ?? 'An error occurred');
      print('Exception @createAccount: $e');
    }
  }
}

Future forgetPasswordMail(String email) async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  try {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    EasyLoading.showSuccess('Reset Password Email sent');

    return true;
  } on FirebaseAuthException catch (e) {
    EasyLoading.showError(e.message.toString());

    return false;
    // show the snackbar here
  }
}

void updateFcmToken() {
  String token = getFcmToken();
  if (token != '') {
    FirebaseFirestore.instance
        .collection('users')
        .doc(getUid())
        .update({'fcm_token': token});
  }
}

Future<Map<dynamic, dynamic>> getUserDetails() async {
  //  Map<String, dynamic> userData = value.data() ?? {};
  //     Map<String, String> stringQueryParameters =
  //         userData.map((key, value) => MapEntry(key, value.toString()));
  //     // saveUserDetails(stringQueryParameters);
  //     return stringQueryParameters;

  Map<String, dynamic> userData = {};
  var variable =
      await FirebaseFirestore.instance.collection('users').doc(getUid()).get();
  userData = variable.data() ?? {};
  Map<String, dynamic> sDMap = Map<String, dynamic>.from(userData);
  Map<String, String> stringQueryParameters = sDMap.map((key, value) {
    return MapEntry(key, value.toString());
  });
  return stringQueryParameters;
}

getMyPayments([String value = '']) {
  // if (value.isNotEmpty) {
  //   if (value == 'completed') {
  //     fStatus = ['2'];
  //   } else {
  //     fStatus = ['1', '0'];
  //   }
  // }

  final Stream<QuerySnapshot> ordersStream = FirebaseFirestore.instance
      .collection('payments')
      .where('user_id', isEqualTo: getUid())
      // .where('status', whereIn: fStatus)
      .snapshots();

  // FirebaseFirestore.instance.collection('orders').where('age', isGreaterThan: 20).snapshots();
  return ordersStream;
}

Future getOrderIdForPayment(deliveryId) async {
  Map<String, dynamic> userData = {};
  Map<String, dynamic> userData2 = {};
  var variable = await FirebaseFirestore.instance
      .collection('deliveries')
      .doc(deliveryId)
      .get();
  userData = variable.data() ?? {};
  Map<String, dynamic> sDMap = Map<String, dynamic>.from(userData);
  Map<String, String> stringQueryParameters = sDMap.map((key, value) {
    return MapEntry(key, value.toString());
  });
  var variable2 = await FirebaseFirestore.instance
      .collection('orders')
      .doc(stringQueryParameters['order_id'])
      .get();
  userData2 = variable2.data() ?? {};
  Map<String, dynamic> sDMap2 = Map<String, dynamic>.from(userData2);
  Map<String, String> stringQueryParameters2 = sDMap2.map((key, value) {
    return MapEntry(key, value.toString());
  });
  stringQueryParameters2['order_id'] = variable2.id;
  return stringQueryParameters2;
}
