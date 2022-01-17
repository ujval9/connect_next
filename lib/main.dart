import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/routes.dart';
import 'utils/themedata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: AppRoutes.routes,
      theme: Themes().lightTheme(),
    );
  }
}
