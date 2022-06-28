import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/locator.dart';

class FirestorePath {
  static String users() => 'users';
  static String user() => 'users/${locator.get<AuthMethods>().uid}';

  static String transactions() =>
      'users/${locator.get<AuthMethods>().uid}/transactions';
  static String transaction(String transactionId) =>
      'users/${locator.get<AuthMethods>().uid}/transactions/$transactionId';

  static String messages() =>
      'users/${locator.get<AuthMethods>().uid}/messages';
  static String message(String messageId) =>
      'users/${locator.get<AuthMethods>().uid}/messages/$messageId';

  static String items() =>
      'users/${locator.get<AuthMethods>().uid}/purchased_items';
  static String item(String itemId) =>
      'users/${locator.get<AuthMethods>().uid}/purchased_items/$itemId';
}
