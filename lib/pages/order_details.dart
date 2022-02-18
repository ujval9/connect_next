import 'package:connectnext_app/utils/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        child: makeBody,
        // width: MediaQuery.of(context).size.width / 2,
      )),
    );
  }

  final makeBody = Column(
    children: [
      Text(
        'From: ' +
            Get.parameters['from_contact_name'].toString() +
            ' - ' +
            Get.parameters['from_contact_number'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Text(
        'Address: ' + Get.parameters['from_address'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Text(
        'Pincode: ' + Get.parameters['from_pincode'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Text(
        'Contact No: ' + Get.parameters['to_contact_number'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Text(
        'To: ' +
            Get.parameters['to_contact_name'].toString() +
            ' - ' +
            Get.parameters['to_contact_number'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Text(
        'Address: ' + Get.parameters['to_address'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Text(
        'Pincode: ' + Get.parameters['to_pincode'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Text(
        'Item-Details: ' + Get.parameters['item_details'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      Text(
        'Deadline: ' + Get.parameters['delivery_deadline'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
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
          child: const Text('Accept'),
          onPressed: () {
            acceptOrder(Get.parameters['id'].toString(),
                '9X51YvsbzYbhWnjimmUtAjFRYr52');
          },
        ),
      ),
    ],
  );
}
