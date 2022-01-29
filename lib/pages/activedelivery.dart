import 'package:flutter/material.dart';

class ActiveDeliveryPage extends StatefulWidget {
  const ActiveDeliveryPage({Key? key}) : super(key: key);

  @override
  _ActiveDeliveryPageState createState() => _ActiveDeliveryPageState();
}

class _ActiveDeliveryPageState extends State<ActiveDeliveryPage> {
  String? _chosenValue = 'live';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text("Connect Next"),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.supervised_user_circle_outlined,
              size: 30,
            ),
            onPressed: () {
              // Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
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
                        'incomplete',
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
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 5),
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                              child: Text("Order Id: $index"),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: Text("From: Borivali"),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: Text("To: Malad"),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                              child: Text("Details ->",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline)),
                            ),
                          ],
                        ),
                      ));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
