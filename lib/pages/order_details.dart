
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

  final makeBody = Card(
    child: Column(
      children: [
        const Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Text(
        'From: ',
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Get.parameters['from_contact_name'].toString() +
            ' - ' +
            Get.parameters['from_contact_number'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    ),
    const Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Text(
        'Address: ',
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Get.parameters['from_address'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    ),
    const Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Text(
        'Pincode: ',
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Get.parameters['from_pincode'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    ),
    const Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Text(
        'Contact No: ',
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Get.parameters['to_contact_number'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    ),
    const Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Text(
        'To: ',
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Get.parameters['to_contact_name'].toString() +
            ' - ' +
            Get.parameters['to_contact_number'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    ),
    const Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Text(
        'Address: ',
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Get.parameters['to_address'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    ),
    const Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Text(
        'Pincode: ',
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Get.parameters['to_pincode'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    ),
    const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Item-Details: ',
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Get.parameters['item_details'].toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    ),
    const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Deadline: ',
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        DateTime.parse(Get.parameters['delivery_deadline'] ?? '').toString(),
        style: const TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    ),
      

    
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
     ]),
  ],),
  );
}

