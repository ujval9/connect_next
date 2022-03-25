import 'package:connectnext_app/pages/delivery_order_details.dart';
import 'package:connectnext_app/pages/login.dart';
import 'package:connectnext_app/pages/master.dart';
import 'package:connectnext_app/pages/order_details.dart';
import 'package:connectnext_app/pages/payments.dart';
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
    GetPage(
      name: '/order_details',
      page: () => const OrderDetailsPage(),
    ),
    GetPage(
      name: '/deliver_order_details',
      page: () => const DeliveryOrderDetailsPage(),
    ),
    GetPage(
      name: '/master',
      page: () => const MasterScreen(),
    ),
    GetPage(
      name: '/mypayments',
      page: () => const MyPayments(),
    ),
  ];
}
