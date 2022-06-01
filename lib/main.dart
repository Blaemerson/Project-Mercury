import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/firebase_options.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/screens/login_screen.dart';
import 'package:projectmercury/screens/navigation_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthMethods _auth = locator.get<AuthMethods>();
    final AnalyticsMethods _analytics = locator.get<AnalyticsMethods>();
    final FirestoreMethods _firestore = locator.get<FirestoreMethods>();

    return MultiProvider(
      providers: [
        StreamProvider<List<PurchasedItem>>(
          create: (context) => _firestore.itemStream,
          initialData: const [],
        )
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
