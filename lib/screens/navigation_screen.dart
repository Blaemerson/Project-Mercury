import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:projectmercury/pages/contactPage/contacts_page.dart';
import 'package:projectmercury/pages/eventPage/event_page.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/resources/time_controller.dart';
import 'package:provider/provider.dart';
import 'package:projectmercury/pages/homePage/home_page.dart';
import 'package:projectmercury/pages/infoPage/info_page.dart';
import 'package:projectmercury/pages/moneyPage/money_page.dart';
import 'package:showcaseview/showcaseview.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final AnalyticsMethods _analytics = locator.get<AnalyticsMethods>();
  final TimerController _timer = locator.get<TimerController>();

  final _key0 = GlobalKey();
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();
  final _key4 = GlobalKey();
  final _key5 = GlobalKey();

  int _pageSelected = 0;
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
    'Events',
    'Info',
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
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[_pageSelected]),
        leading: IconButton(
          onPressed: () => setState(() {
            ShowCaseWidget.of(context)
                .startShowCase([_key0, _key1, _key2, _key3, _key4, _key5]);
          }),
          icon: const Icon(Icons.help_rounded),
        ),
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
            return Showcase(
              key: _key0,
              description: 'This is the navigation bar.',
              overlayPadding: const EdgeInsets.all(8),
              showArrow: false,
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
                    icon: Showcase(
                      key: _key1,
                      description: 'This is the home page.',
                      overlayPadding: const EdgeInsets.fromLTRB(12, 10, 12, 28),
                      child: Badge(
                        showBadge: event.showBadge[0],
                        badgeContent: Icon(
                          Icons.notification_important,
                          size: 28,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: const Icon(Icons.home),
                      ),
                    ),
                    label: pageTitles[0],
                  ),
                  BottomNavigationBarItem(
                    icon: Showcase(
                      key: _key2,
                      description: 'This is the money page.',
                      overlayPadding: const EdgeInsets.fromLTRB(12, 10, 12, 28),
                      child: Badge(
                        showBadge: event.showBadge[1],
                        badgeContent: Icon(
                          Icons.notification_important,
                          size: 28,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: const Icon(Icons.money),
                      ),
                    ),
                    label: pageTitles[1],
                  ),
                  BottomNavigationBarItem(
                    icon: Showcase(
                      key: _key3,
                      description: 'This is the contacts page.',
                      overlayPadding: const EdgeInsets.fromLTRB(12, 10, 12, 28),
                      child: Badge(
                        showBadge: event.showBadge[2],
                        badgeContent: Icon(
                          Icons.notification_important,
                          size: 28,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: const Icon(Icons.people),
                      ),
                    ),
                    label: pageTitles[2],
                  ),
                  BottomNavigationBarItem(
                    icon: Showcase(
                      key: _key4,
                      description: 'This is the events page.',
                      overlayPadding: const EdgeInsets.fromLTRB(12, 10, 12, 28),
                      child: Badge(
                        showBadge: event.showBadge[3],
                        badgeContent: Icon(
                          Icons.notification_important,
                          size: 28,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: const Icon(Icons.mail),
                      ),
                    ),
                    label: pageTitles[3],
                  ),
                  BottomNavigationBarItem(
                    icon: Showcase(
                      key: _key5,
                      description: 'This is the info page.',
                      overlayPadding: const EdgeInsets.fromLTRB(12, 10, 12, 28),
                      child: Badge(
                        showBadge: event.showBadge[4],
                        badgeContent: Icon(
                          Icons.notification_important,
                          size: 28,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        child: const Icon(Icons.info),
                      ),
                    ),
                    label: pageTitles[4],
                  ),
                ],
                onTap: onNavTapped,
              ),
            );
          },
        ),
      ),
    );
  }
}
