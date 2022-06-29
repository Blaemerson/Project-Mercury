import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/firebase_options.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/screens/welcome_screen.dart';
import 'package:projectmercury/screens/navigation_screen.dart';

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

    ColorScheme _color = ColorScheme.fromSeed(
      seedColor: Colors.red,
    );

    return MaterialApp(
      title: 'Project Mercury',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      navigatorObservers: [
        _analytics.getAnalyticObserver(),
      ],
      theme: ThemeData(
        colorScheme: _color,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(_color.primary),
              foregroundColor: MaterialStateProperty.all(_color.onPrimary)),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 36,
            color: _color.onPrimary,
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
              _firestore.initializeData(_auth.currentUser);
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
          // return login screen if user not logged in
          _analytics.setCurrentScreen('/login');
          return const WelcomeScreen();
        },
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
