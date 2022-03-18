import 'package:connectnext_app/utils/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/get_storage_service.dart';

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
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "FROM DETAILS",
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From: ' + Get.parameters['from_contact_name'].toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () => _launchURL('tel:' +
                      Get.parameters['from_contact_number'].toString()),
                  child: Text.rich(
                    TextSpan(
                      text: 'Contact: ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              Get.parameters['from_contact_number'].toString(),
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Address: ' + Get.parameters['from_address'].toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  'Pincode: ' + Get.parameters['from_pincode'].toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  'Contact No: ' +
                      Get.parameters['to_contact_number'].toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () =>
                      _launchURL(Get.parameters['from_gmaps_link'].toString()),
                  child: Text(
                    'Gmaps Links: ' +
                        Get.parameters['from_gmaps_link'].toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "TO DETAILS",
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To: ' + Get.parameters['to_contact_name'].toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () => _launchURL(
                      'tel:' + Get.parameters['to_contact_number'].toString()),
                  child: Text.rich(
                    TextSpan(
                      text: 'Contact: ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                          text: Get.parameters['to_contact_number'].toString(),
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Address: ' + Get.parameters['to_address'].toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  'Pincode: ' + Get.parameters['to_pincode'].toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () =>
                      _launchURL(Get.parameters['to_gmaps_link'].toString()),
                  child: Text(
                    'Gmaps Links: ' +
                        Get.parameters['to_gmaps_link'].toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "OTHER DETAILS",
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item Details: ' +
                        Get.parameters['item_details'].toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Order Description: ' +
                        Get.parameters['description'].toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Deadline: ' +
                        Get.parameters['delivery_deadline'].toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )),
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
            acceptOrder(Get.parameters['id'].toString(), getUid());
          },
        ),
      ),
    ],
  );
}

void _launchURL(url) async {
  if (!await launch(url)) {
    EasyLoading.showError('Error Occured ,Please Try Again');
  }
}
