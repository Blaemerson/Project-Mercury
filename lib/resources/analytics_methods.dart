import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsMethods {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future setCurrentScreen(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }
}
