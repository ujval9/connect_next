import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'activedelivery.dart';
import 'dashboard.dart';

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
      // resizeToAvoidBottomInset: true,
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Center(
          child: Text("Order Details"),
        ),
      ),
      body: makeBody,
    );
  }

  final makeBody = SingleChildScrollView(
    physics: const ScrollPhysics(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(
            child: Card(
              color: Colors.white,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'From: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      Get.parameters['from_contact_name'].toString() +
                          ' - ' +
                          Get.parameters['from_contact_number'].toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Address: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      Get.parameters['from_address'].toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Pincode: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      Get.parameters['from_pincode'].toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ListTile(
                  //   title: const Text(
                  //     'Contact No: ',
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 18.0,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  //   subtitle: Text(
                  //     Get.parameters['to_contact_number'].toString(),
                  //     style: const TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 15.0,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  ListTile(
                    title: const Text(
                      'To: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      Get.parameters['to_contact_name'].toString() +
                          ' - ' +
                          Get.parameters['to_contact_number'].toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Address: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      Get.parameters['to_address'].toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Pincode: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      Get.parameters['to_pincode'].toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ListTile(
                  //   title: const Text(
                  //     'Contact No: ',
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 18.0,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  //   subtitle: Text(
                  //     Get.parameters['to_contact_number'].toString(),
                  //     style: const TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 15.0,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  ListTile(
                    title: const Text(
                      'Delivery Deadline: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateTime.parse(Get.parameters['delivery_deadline'] ?? '')
                          .toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Item Details: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      Get.parameters['item_details'].toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white, fontSize: 20),
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Accept'),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  );
}
