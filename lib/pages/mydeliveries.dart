import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectnext_app/utils/firebase_service.dart';
import 'package:connectnext_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDeliveryPage extends StatefulWidget {
  const MyDeliveryPage({Key? key}) : super(key: key);

  @override
  MyDeliveryPageState createState() => MyDeliveryPageState();
}

class MyDeliveryPageState extends State<MyDeliveryPage> {
  late Stream<QuerySnapshot> ordersStream = getMyOrders();

  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  String? _chosenValue = 'live';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text("Connect Next"),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Deliveries",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Spacer(),
                    DropdownButton<String>(
                      focusColor: Colors.white,
                      value: _chosenValue,
                      //elevation: 5,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>[
                        'live',
                        'completed',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),

                      onChanged: (String? value) {
                        ordersStream = getMyOrders(value ?? '');
                        setState(() {
                          _chosenValue = value;
                          print(_chosenValue);
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
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
                        'No Deliveries yet',
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
                          return Card(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                  child: Text('Order Id:' +
                                      storedocs[index]['order_id']),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                  child: Text('Status: ' +
                                      getStatus(storedocs[index]['status'])),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 10),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.black,
                                        ),
                                      ),
                                      onPressed: () {
                                        getSingleOrder(storedocs[index]).then(
                                          (value) => Get.toNamed(
                                              "/deliver_order_details",
                                              parameters: value),
                                        );
                                      },
                                      child: const Text("View Details",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.underline))),
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
