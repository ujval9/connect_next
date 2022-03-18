import 'package:connectnext_app/pages/payments.dart';
import 'package:connectnext_app/pages/profile/profile_menu.dart';
import 'package:connectnext_app/pages/profile/profile_pic.dart';
import 'package:connectnext_app/pages/profile/profilepage_view.dart';
import 'package:connectnext_app/utils/get_storage_service.dart';
import 'package:flutter/material.dart';

import '../utils/firebase_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const ProfilePic(),
              const SizedBox(height: 20),
              ProfileMenu(
                text: "My Account",
                icon: "assets/icons/User Icon.svg",
                press: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileView())),
                },
              ),
              ProfileMenu(
                text: "Payments",
                icon: "assets/icons/Rupee-Symbol-Black.svg",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyPayments()));
                },
              ),
              ProfileMenu(
                text: "Help Center",
                icon: "assets/icons/Question mark.svg",
                press: () {},
              ),
              GestureDetector(
                onTap: () => logout(),
                child: ProfileMenu(
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () {
                    logout();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
