import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectnext_app/utils/firebase_service.dart';
import 'package:connectnext_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryOrderDetailsPage extends StatefulWidget {
  const DeliveryOrderDetailsPage({Key? key}) : super(key: key);

  @override
  _DeliveryOrderDetailsPageState createState() =>
      _DeliveryOrderDetailsPageState();
}

class _DeliveryOrderDetailsPageState extends State<DeliveryOrderDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  String? _chosenValue = 'In Transit';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        child: Column(
          children: [
            Text(
              'From: ' +
                  Get.parameters['from_contact_name'].toString() +
                  ' - ' +
                  Get.parameters['from_contact_number'].toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Address: ' + Get.parameters['from_address'].toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Pincode: ' + Get.parameters['from_pincode'].toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Contact No: ' + Get.parameters['to_contact_number'].toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'To: ' +
                  Get.parameters['to_contact_name'].toString() +
                  ' - ' +
                  Get.parameters['to_contact_number'].toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Address: ' + Get.parameters['to_address'].toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Pincode: ' + Get.parameters['to_pincode'].toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Item-Details: ' + Get.parameters['item_details'].toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Deadline: ' + Get.parameters['delivery_deadline'].toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            if (Get.parameters['delivery_status'].toString() == '2')
              Text(
                'Last Updated At : ' +
                    getDateFromTimestamp(Get.parameters['delivery_updated_at']),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            if (Get.parameters['delivery_status'].toString() != '2')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.black,
                    ),
                  ),
                  child: const Text('Update Status'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Update' +
                              Get.parameters['delivery_status'].toString()),
                          content: Column(
                            children: [
                              DropdownButton<String>(
                                focusColor: Colors.white,
                                value: _chosenValue,
                                //elevation: 5,
                                style: const TextStyle(color: Colors.white),
                                iconEnabledColor: Colors.black,
                                items: <String>[
                                  'In Transit',
                                  'completed',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),

                                onChanged: (String? value) {
                                  setState(() {
                                    _chosenValue = value;
                                    print(_chosenValue);
                                  });
                                },
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    updateOrder(
                                        Get.parameters['order_id'].toString(),
                                        Get.parameters['delivery_id']
                                            .toString(),
                                        _chosenValue ?? '');
                                  },
                                  child: Text("Submit"))
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          ],
        ),
        // width: MediaQuery.of(context).size.width / 2,
      )),
    );
  }
}
