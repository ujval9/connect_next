import 'dart:developer';
import 'package:connectnext_app/utils/firebase_service.dart';
import 'package:connectnext_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final TextEditingController _otpcontroller = TextEditingController();
  String? _chosenValue = 'In Transit';
  bool _showotp = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "FROM DETAILS",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
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
                        'From: ' +
                            Get.parameters['from_contact_name'].toString(),
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
                                text: Get.parameters['from_contact_number']
                                    .toString(),
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
                        onTap: () => _launchURL(
                            Get.parameters['from_gmaps_link'].toString()),
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
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
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
                        onTap: () => _launchURL('tel:' +
                            Get.parameters['to_contact_number'].toString()),
                        child: Text.rich(
                          TextSpan(
                            text: 'Contact: ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                text: Get.parameters['to_contact_number']
                                    .toString(),
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
                        onTap: () => _launchURL(
                            Get.parameters['to_gmaps_link'].toString()),
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
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
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
                          'Item-Details: ' +
                              Get.parameters['item_details'].toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Order Description: ' +
                              Get.parameters['deliveries'].toString(),
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
            if (Get.parameters['delivery_status'].toString() == '2')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Started Updated At : ' +
                          getDateFromTimestamp(
                              Get.parameters['delivery_created_at']),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Last Updated At : ' +
                          getDateFromTimestamp(
                              Get.parameters['delivery_updated_at']),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
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
                        return StatefulBuilder(
                            builder: (context, StateSetter setState) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            title: const Text('Update'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
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
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    );
                                  }).toList(),

                                  onChanged: (String? value) {
                                    setState(() {
                                      _chosenValue = value;
                                      if (value == 'completed') {
                                        _showotp = true;
                                      } else {
                                        _showotp = false;
                                      }
                                      log(_showotp.toString());
                                      print(_chosenValue);
                                    });
                                  },
                                ),
                                if (_showotp)
                                  TextFormField(
                                    validator: (value) {
                                      if ((_showotp) && (value!.isEmpty)) {
                                        return 'Please enter OTP';
                                      }
                                      return null;
                                    },
                                    controller: _otpcontroller,
                                    decoration: InputDecoration(
                                        hintText: 'Customer otp',
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 3.0))),
                                  ),
                                ElevatedButton(
                                    onPressed: () {
                                      updateOrder(
                                          Get.parameters['order_id'].toString(),
                                          Get.parameters['delivery_id']
                                              .toString(),
                                          _chosenValue ?? '',
                                          _otpcontroller.text);
                                    },
                                    child: const Text("Submit"))
                              ],
                            ),
                          );
                        });
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

void _launchURL(url) async {
  if (!await launch(url)) {
    EasyLoading.showError('Error Occured ,Please Try Again');
  }
}
