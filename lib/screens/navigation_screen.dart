import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:projectmercury/pages/contactPage/contacts_page.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/badge_controller.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/resources/time_controller.dart';
import 'package:provider/provider.dart';

import '../pages/homePage/home_page.dart';
import '../pages/infoPage/info_page.dart';
import '../pages/messagePage/messages_page.dart';
import '../pages/moneyPage/money_page.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final AnalyticsMethods _analytics = locator.get<AnalyticsMethods>();
  final TimerController _timer = locator.get<TimerController>();
  final BadgeController _badge = locator.get<BadgeController>();

  int _pageSelected = 0;
  List<Widget> pages = const [
    HomePage(),
    MoneyPage(),
    ContactPage(),
    MessagePage(),
    InfoPage(),
  ];
  List<String> pageTitles = const [
    '/home',
    '/money',
    '/contacts',
    '/mail',
    '/info',
  ];

  void onNavTapped(int index) {
    setState(() {
      _analytics.setCurrentScreen(pageTitles[index]);
      _pageSelected = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _timer.start();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Navigator.canPop(context) ? Navigator.pop(context) : null;
    return ChangeNotifierProvider.value(
      value: _badge,
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: pages[_pageSelected],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
          ),
          child: Consumer<BadgeController>(
            builder: (_, badge, __) {
              return BottomNavigationBar(
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
                      showBadge: badge.showBadge[0],
                      badgeContent: Icon(
                        Icons.notification_important,
                        size: 28,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: const Icon(Icons.home),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Badge(
                      showBadge: badge.showBadge[1],
                      badgeContent: Icon(
                        Icons.notification_important,
                        size: 28,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: const Icon(Icons.money),
                    ),
                    label: 'Money',
                  ),
                  BottomNavigationBarItem(
                    icon: Badge(
                      showBadge: badge.showBadge[2],
                      badgeContent: Icon(
                        Icons.notification_important,
                        size: 28,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: const Icon(Icons.people),
                    ),
                    label: 'Contacts',
                  ),
                  BottomNavigationBarItem(
                    icon: Badge(
                      showBadge: badge.showBadge[3],
                      badgeContent: Icon(
                        Icons.notification_important,
                        size: 28,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: const Icon(Icons.mail),
                    ),
                    label: 'Mail',
                  ),
                  BottomNavigationBarItem(
                    icon: Badge(
                      showBadge: badge.showBadge[4],
                      badgeContent: Icon(
                        Icons.notification_important,
                        size: 28,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: const Icon(Icons.info),
                    ),
                    label: 'Info',
                  ),
                ],
                onTap: onNavTapped,
              );
            },
          ),
        ),
      ),
    );
  }
}
