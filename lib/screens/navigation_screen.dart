import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:projectmercury/pages/contactPage/contacts_page.dart';
import 'package:projectmercury/pages/eventPage/event_page.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/resources/time_controller.dart';
import 'package:projectmercury/resources/tutorial.dart';
import 'package:provider/provider.dart';
import 'package:projectmercury/pages/homePage/home_page.dart';
import 'package:projectmercury/pages/infoPage/info_page.dart';
import 'package:projectmercury/pages/moneyPage/money_page.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final AnalyticsMethods _analytics = locator.get<AnalyticsMethods>();
  final TimerController _timer = locator.get<TimerController>();

  List<Widget> pages = const [
    HomePage(),
    MoneyPage(),
    ContactPage(),
    EventPage(),
    InfoPage(),
  ];
  List<String> pageTitles = const [
    'Home',
    'Money',
    'Contacts',
    'Mail',
    'Info',
  ];

  void onNavTapped(int index) {
    setState(() {
      _analytics.setCurrentScreen(pageTitles[index]);
      locator.get<EventController>().currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    locator.get<FirestoreMethods>().initializeSubscriptions();
    _timer.start();
  }

  @override
  void dispose() {
    super.dispose();
    locator.get<FirestoreMethods>().cancelSubscriptions();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Navigator.canPop(context) ? Navigator.pop(context) : null;
    int _pageSelected = locator.get<EventController>().currentPage;
    Tutorial _tutorial = locator.get<Tutorial>();
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[_pageSelected]),
        actions: [
          IconButton(
            onPressed: () => setState(() {
              _tutorial.showTutorial(context);
            }),
            icon: const Icon(Icons.help_rounded),
          ),
        ],
      ),
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
        child: Consumer<EventController>(
          builder: (_, event, __) {
            return BottomNavigationBar(
              key: _tutorial.navBarKey,
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
                    key: _tutorial.navItemKey1,
                    showBadge: event.showBadge[0],
                    badgeContent: Icon(
                      Icons.notification_important,
                      size: 28,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Icon(Icons.home),
                  ),
                  label: pageTitles[0],
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    key: _tutorial.navItemKey2,
                    showBadge: event.showBadge[1],
                    badgeContent: Icon(
                      Icons.notification_important,
                      size: 28,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Icon(Icons.money),
                  ),
                  label: pageTitles[1],
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    key: _tutorial.navItemKey3,
                    showBadge: event.showBadge[2],
                    badgeContent: Icon(
                      Icons.notification_important,
                      size: 28,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Icon(Icons.people),
                  ),
                  label: pageTitles[2],
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    key: _tutorial.navItemKey4,
                    showBadge: event.showBadge[3],
                    badgeContent: Icon(
                      Icons.notification_important,
                      size: 28,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Icon(Icons.mail),
                  ),
                  label: pageTitles[3],
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    key: _tutorial.navItemKey5,
                    showBadge: event.showBadge[4],
                    badgeContent: Icon(
                      Icons.notification_important,
                      size: 28,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Icon(Icons.info),
                  ),
                  label: pageTitles[4],
                ),
              ],
              onTap: onNavTapped,
            );
          },
        ),
      ),
    );
  }
}
