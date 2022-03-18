import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectnext_app/utils/firebase_service.dart';
import 'package:connectnext_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyPayments extends StatefulWidget {
  const MyPayments({Key? key}) : super(key: key);

  @override
  MyPaymentsState createState() => MyPaymentsState();
}

class MyPaymentsState extends State<MyPayments> {
  late Stream<QuerySnapshot> ordersStream = getMyPayments();

  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  String? _chosenValue = 'live';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments"),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: ordersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print('Something went Wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Payments yet',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    );
                  }

                  final List storedocs = [];
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> a =
                        document.data() as Map<String, dynamic>;
                    storedocs.add(a);
                    a['id'] = document.id;
                  }).toList();
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 5),
                        itemCount: storedocs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var isPaid = storedocs[index]['ispaid'] == true
                              ? 'Paid'
                              : 'Not Paid';
                          var updated_at = DateFormat('dd/MM/yyyy, hh:mm a')
                              .format(storedocs[index]['updated_at'].toDate());
                          return Card(
                              color: const Color(0xFFF5F6F9),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder(
                                      future: getOrderIdForPayment(
                                          storedocs[index]['delivery_id']),
                                      builder: (ctx, AsyncSnapshot snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          // If we got an error
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                '${snapshot.error} occured',
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            );
                                            // if we got our data
                                          } else if (snapshot.hasData) {
                                            // Extracting data from snapshot object
                                            final data = snapshot.data;

                                            return Text('Order ID: ' +
                                                data['order_id']);
                                          } else {
                                            return Text(
                                                snapshot.data.toString());
                                          }
                                        }

                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text('Base Amount:' +
                                          storedocs[index]['base_amount']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text('Final Amount:' +
                                          storedocs[index]['final_amount']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text('Payment Status: ' + isPaid),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text('Updated At: ' + updated_at),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
