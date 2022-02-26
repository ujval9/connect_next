import 'package:connectnext_app/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    setState(
      () {
        _selectedIndex = int.parse(Get.parameters['index'] ?? '0');
      },
    );
    _pageController = PageController(
      initialPage: _selectedIndex,
    );
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
