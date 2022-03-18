import 'package:flutter/material.dart';

import '../../utils/firebase_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Profile Details"),
      ),
      body: const ProfileDetailsView(),
    );
  }
}

class ProfileDetailsView extends StatelessWidget {
  const ProfileDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserDetails(),
      builder: (ctx, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occured',
                style: TextStyle(fontSize: 18),
              ),
            );

            // if we got our data
          } else if (snapshot.hasData) {
            // Extracting data from snapshot object
            final data = snapshot.data;
            final name =
                snapshot.data['f_name'] + ' ' + snapshot.data['l_name'];
            final uid = snapshot.data['uid'];
            final contact_no = snapshot.data['contact_no'];
            final email = snapshot.data['email'];
            final aadhar_no = snapshot.data['aadhar_no'];
            final alternate_mobile_no = snapshot.data['alternate_mobile_no'];
            final address = snapshot.data['address_line1'] +
                ',' +
                snapshot.data['address_line2'] +
                ',' +
                snapshot.data['city'] +
                ',' +
                snapshot.data['state'] +
                ',' +
                snapshot.data['pin_code'];
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getHeadTextWidget('Username'),
                  const SizedBox(height: 10),
                  getChildTextWidget(name),
                  const Divider(
                    color: Colors.black,
                  ),
                  getHeadTextWidget('Contact Number'),
                  const SizedBox(height: 10),
                  getChildTextWidget(contact_no),
                  const Divider(
                    color: Colors.black,
                  ),
                  getHeadTextWidget('Email'),
                  const SizedBox(height: 10),
                  getChildTextWidget(email),
                  const Divider(
                    color: Colors.black,
                  ),
                  getHeadTextWidget('Address'),
                  const SizedBox(height: 10),
                  getChildTextWidget(address),
                  const Divider(
                    color: Colors.black,
                  ),
                  getHeadTextWidget('Alternate Mobile Number'),
                  const SizedBox(height: 10),
                  getChildTextWidget(alternate_mobile_no),
                  const Divider(
                    color: Colors.black,
                  ),
                  getHeadTextWidget('Aadhar Number'),
                  const SizedBox(height: 10),
                  getChildTextWidget(aadhar_no),
                  const Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

Widget getHeadTextWidget(value) {
  return Text(
    value,
    style: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget getChildTextWidget(value) {
  return Text(
    value,
    style: const TextStyle(
      fontSize: 15,
      color: Colors.black,
    ),
  );
}
