import 'dart:developer';

import 'package:connectnext_app/pages/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/firebase_service.dart';
import 'mydeliveries.dart';
import 'dashboard.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({Key? key}) : super(key: key);

  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final List<Widget> _screens = [
    const DashboardPage(),
    const MyDeliveryPage(),
    const ProfilePage(),
  ];

  int _selectedIndex = 0;
  PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    updateFcmToken();
    setState(
      () {
        _selectedIndex = int.parse(Get.parameters['index'] ?? '0');
      },
    );
    _pageController = PageController(
      initialPage: _selectedIndex,
    );
    setupInteractedMessage();
  }

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    log("message");
    // String link = message.data['link'] ?? '';
    // Navigator.pushNamed(context, '/' + link);
    Get.toNamed('/mypayments');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          onTabTapped(_selectedIndex);
        },
        selectedItemColor: Colors.white,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(Icons.grid_view),
            activeIcon: Icon(
              Icons.grid_view,
              size: 40,
            ),
          ),
          BottomNavigationBarItem(
            label: "My Deliveries",
            icon: Icon(Icons.access_time_outlined),
            activeIcon: Icon(
              Icons.access_time_outlined,
              size: 40,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
            activeIcon: Icon(
              Icons.person,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }
}
