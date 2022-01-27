import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/routes.dart';
import 'utils/themedata.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          //check for errors
          if (snapshot.hasError) {
            print("Something went wong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return GetMaterialApp(
              initialRoute: '/',
              getPages: AppRoutes.routes,
              theme: Themes().lightTheme(),
            );
          }        
        return CircularProgressIndicator();
        });
  }
}
