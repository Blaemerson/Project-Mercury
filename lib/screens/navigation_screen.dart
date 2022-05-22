import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:projectmercury/utils/global_variables.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _pageSelected = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

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
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: navBarPages,
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
