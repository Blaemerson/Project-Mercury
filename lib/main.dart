import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/firebase_options.dart';
import 'package:projectmercury/models/contact.dart';
import 'package:projectmercury/models/message.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/models/transaction.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/resources/timeController.dart';
import 'package:projectmercury/screens/login_screen.dart';
import 'package:projectmercury/screens/navigation_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthMethods _auth = locator.get<AuthMethods>();
    final AnalyticsMethods _analytics = locator.get<AnalyticsMethods>();
    final FirestoreMethods _firestore = locator.get<FirestoreMethods>();
    final TimerController _timer = locator.get<TimerController>();

    return MultiProvider(
      // TODO: move each provider down widget tree
      providers: [
        StreamProvider<List<Transaction>>(
          create: (context) => _firestore.userTransaction.stream,
          initialData: const [],
        ),
        StreamProvider<List<PurchasedItem>>(
          create: (context) => _firestore.userItem.stream,
          initialData: const [],
        ),
        StreamProvider<List<StoreItem>>(
          create: (context) => _firestore.store.stream,
          initialData: const [],
        ),
        StreamProvider<List<Contact>>(
          create: ((context) => _firestore.contact.stream),
          initialData: const [],
        ),
        StreamProvider<List<Message>>(
          create: (context) => _firestore.userMessage.stream,
          initialData: const [],
        ),
        ChangeNotifierProvider<TimerController>.value(value: _timer),
      ],
      child: MaterialApp(
        title: 'Project Mercury',
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        navigatorObservers: [
          _analytics.getAnalyticObserver(),
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 36,
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: StreamBuilder(
          // listen to authentication changes
          stream: _auth.userStream,
          builder: (context, snapshot) {
            // return nav screen if user logged in
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                _firestore.user.initialize(_auth.currentUser);
                _analytics.setCurrentScreen('/home');
                return const NavigationScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            // return indicator if loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // return login screen in user not logged in
            _analytics.setCurrentScreen('/login');
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

// enable mouse scroll on web
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
