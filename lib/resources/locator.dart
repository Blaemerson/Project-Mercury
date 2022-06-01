import 'package:get_it/get_it.dart';
import 'package:projectmercury/resources/analytics_methods.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/firestore_methods.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AuthMethods>(() => AuthMethods());
  locator.registerLazySingleton<FirestoreMethods>(() => FirestoreMethods());
  locator.registerLazySingleton<AnalyticsMethods>(() => AnalyticsMethods());
}
