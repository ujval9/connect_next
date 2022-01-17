import 'package:connectnext_app/pages/login.dart';
import 'package:connectnext_app/pages/master.dart';
import 'package:connectnext_app/pages/splash.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/master', page: () => const MasterScreen()),

    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
    ),

    // GetPage(
    //   name: '/properks',
    //   page: () => ProperksScreen(),
    // ),
  ];
}
