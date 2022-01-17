import 'package:connectnext_app/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'activedelivery.dart';
import 'dashboard.dart';

class MasterScreen extends StatefulWidget {
  const MasterScreen({Key? key}) : super(key: key);

  @override
  _MasterScreenState createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  int _currentIndex = 0;
  final List _screens = [
    const DashboardPage(),
    const ActiveDeliveryPage(),
    const ProfilePage(),
  ];
  void _updateIndex(int value) {
    setState(
      () {
        _currentIndex = value;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    setState(
      () {
        _currentIndex = int.parse(Get.parameters['index'] ?? '0');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        selectedItemColor: Colors.white,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            label: "Dashboard",
            icon: Icon(Icons.grid_view),
          ),
          BottomNavigationBarItem(
            label: "Active Delivery",
            icon: Icon(Icons.access_time_outlined),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
