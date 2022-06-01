import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/locator.dart';

import '../pages/contacts_page.dart';
import '../pages/home_page.dart';
import '../pages/info_page.dart';
import '../pages/messages_page.dart';
import '../pages/money_page.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final AnalyticsMethods _analytics = locator.get<AnalyticsMethods>();
  int _pageSelected = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _pageSelected = index;
    });
  }

  void onNavTapped(int index) {
    setState(() {
      _pageSelected = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _analytics.setCurrentScreen("Home");
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomePage(),
          MoneyPage(),
          ContactsPage(),
          MessagesPage(),
          InfoPage(),
        ],
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _pageSelected,
          iconSize: 50,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Badge(
                showBadge: false,
                badgeContent: const Text(''),
                child: const Icon(Icons.home),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                badgeContent: const Text(''),
                child: const Icon(Icons.money),
              ),
              label: 'Money',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                badgeContent: const Text(''),
                child: const Icon(Icons.people),
              ),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                showBadge: false,
                badgeContent: const Text(''),
                child: const Icon(Icons.mail),
              ),
              label: 'Mail',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                showBadge: false,
                badgeContent: const Text(''),
                child: const Icon(Icons.info),
              ),
              label: 'Info',
            ),
          ],
          onTap: onNavTapped,
        ),
      ),
    );
  }
}
