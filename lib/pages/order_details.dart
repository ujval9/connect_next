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
    print(Get.parameters['from_area']);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Connect Next"),
        ),
        body: SafeArea(
            child: Center(
              
          child: Text(Get.parameters['from_area'].toString()),
        )));
    // return
  }
}
