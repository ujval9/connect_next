import 'package:cloud_firestore/cloud_firestore.dart';

getOrders() {
  final Stream<QuerySnapshot> ordersStream =
      FirebaseFirestore.instance.collection('orders').snapshots();
  return ordersStream;
}
