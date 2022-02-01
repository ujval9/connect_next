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
  final List<Widget> _screens = [
    const DashboardPage(),
    const ActiveDeliveryPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    setState(
      () {
        _currentIndex = int.parse(Get.parameters['index'] ?? '0');
      },
    );
  }

  final PageController _pageController = PageController();
  int _selectedIndex = 0;
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
        currentIndex: _currentIndex,
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
          ),
          BottomNavigationBarItem(
            label: "My Deliveries",
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

  void onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }
}
