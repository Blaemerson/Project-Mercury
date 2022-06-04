import 'package:get_it/get_it.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/timeController.dart';

final locator = GetIt.instance;

void setupLocator() {
  // methods associated with Firebase Auth
  locator.registerLazySingleton<AuthMethods>(() => AuthMethods());
  // methods associated with Firebase Firestore
  locator.registerLazySingleton<FirestoreMethods>(() => FirestoreMethods());
  // methods  associated with Firebase Analytics
  locator.registerLazySingleton<AnalyticsMethods>(() => AnalyticsMethods());
  // methods associated with timers
  locator.registerLazySingleton<TimerController>(() => TimerController());
}
