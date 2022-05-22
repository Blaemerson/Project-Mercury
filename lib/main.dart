import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/screens/login_screen.dart';
import 'package:projectmercury/screens/navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // initialize web app
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD_66gY3_juIPgWDaWaqGSp4X0Yt5ScTr0",
        appId: "1:205829397512:web:24b9114be0ca2b1f0745bd",
        messagingSenderId: "205829397512",
        projectId: "project-mercury-prototype",
        storageBucket: "project-mercury-prototype.appspot.com",
      ),
    );
  } else {
    // initialize Android/IOS app
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Mercury',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      navigatorObservers: [
        AnalyticsMethods().getAnalyticObserver(),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent,
          brightness: Brightness.dark,
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
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // return nav screen if user logged in
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
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
