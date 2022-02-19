import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'get_storage_service.dart';

getOrders() {
  final Stream<QuerySnapshot> ordersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();
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
  Map<String, String> stringQueryParameters =
      sDMap.map((key, value) => MapEntry(key, value.toString()));

  stringQueryParameters['delivery_status'] = delivery['status'];
  stringQueryParameters['delivery_updated_at'] =
      delivery['updated_at'].toDate().toString();
  stringQueryParameters['order_id'] = delivery['order_id'];

  stringQueryParameters['delivery_id'] = delivery['id'];
  return stringQueryParameters;
}

getMyOrders([String value = '']) {
  log(value.toString());
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
      .where('user_id', isEqualTo: '9X51YvsbzYbhWnjimmUtAjFRYr52')
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

updateOrder(String orderId, String deliveryId, String status) {
  CollectionReference deliveries =
      FirebaseFirestore.instance.collection('deliveries');
  CollectionReference order = FirebaseFirestore.instance.collection('orders');
  if (status == 'In Transit') {
    status = '1';
  } else if (status == 'completed') {
    status = '2';
  } else {
    status = '0';
  }

  deliveries.doc(deliveryId).update({'status': status}).then((value) {
    if (status == '2') {
      order.doc(orderId).update({'status': 'started'}).then((value) {
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
      saveUserLogin(uid, true);

      Get.offAllNamed('/master');
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
