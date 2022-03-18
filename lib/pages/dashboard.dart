import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectnext_app/utils/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Stream<QuerySnapshot> ordersStream;

  @override
  void initState() {
    ordersStream = getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect Next"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.9,
                      1,
                    ],
                    colors: [
                      Colors.yellow,
                      Color(0xfffffca2),
                    ],
                  )),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              Size(
                                MediaQuery.of(context).size.width / 1.5,
                                MediaQuery.of(context).size.height / 15,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black,
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Select a new order'),
                          ),
                          onPressed: () {
                            // print("SUBMITTED");
                          },
                        ),
                      ]),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                          'No New Orders',
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
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 10, 5, 0),
                                      child: Text(
                                          'Order Id:' + storedocs[index]['id']),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      child: Text('From:' +
                                          storedocs[index]['from_area']),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      child: Text(
                                          'To: ' + storedocs[index]['to_area']),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      child: Text('Base Amount: ' +
                                          storedocs[index]['base_amount']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 10),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              Colors.black,
                                            ),
                                          ),
                                          onPressed: () {
                                            Map<String, dynamic> sDMap =
                                                Map<String, dynamic>.from(
                                                    storedocs[index]);
                                            Map<String, String>
                                                stringQueryParameters =
                                                sDMap.map(
                                              (key, value) {
                                                if (key ==
                                                    'delivery_deadline') {
                                                  return MapEntry(
                                                      key,
                                                      DateFormat(
                                                              'dd/MM/yyyy, hh:mm a')
                                                          .format(
                                                              value.toDate()));
                                                } else {
                                                  return MapEntry(
                                                      key, value.toString());
                                                }
                                              },
                                            );
                                            var parameters =
                                                stringQueryParameters;
                                            Get.toNamed("/order_details",
                                                parameters: parameters);
                                          },
                                          child: const Text("View Details",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  decoration: TextDecoration
                                                      .underline))),
                                    ),
                                  ],
                                ),
                              ),
                            );
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
      ),
    );
  }
}

class BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();
    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height / 2));
    paint.color = Colors.yellow;
    canvas.drawPath(mainBackground, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
