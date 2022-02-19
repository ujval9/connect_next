import 'package:connectnext_app/utils/get_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checksession() async {
    bool loggedin = getLoggedIn() ?? false;

    if (loggedin != false) {
      return '/master';
    } else {
      return '/login';
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      checksession().then((value) {
        Get.offAllNamed(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow,
        child: const Center(
            child: Text(
          "Connect Next",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
