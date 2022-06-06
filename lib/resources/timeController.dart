import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:projectmercury/resources/auth_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerController with ChangeNotifier {
  late SharedPreferences prefs;
  late final String uid = locator.get<AuthMethods>().currentUser.uid;

  int _totalTime = 0;
  int _sessionTime = 0;
  Timer? _timer;

  String get totalTime => _printDuration(Duration(seconds: _totalTime));
  String get sessionTime => _printDuration(Duration(seconds: _sessionTime));

// start timer
  void start() async {
    // local storage on disk
    prefs = await SharedPreferences.getInstance();
    // load stored times
    _totalTime = getLocalTime('totalTime');
    _sessionTime = 0;
    // run every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _totalTime += 1;
      _sessionTime += 1;
      incrementLocalTime('totalTime');
      incrementLocalTime('sessionTime');
      notifyListeners();
    });
  }

// format time in HH:mm:ss format
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

// run when new session started
  void resetSessionTime() {
    prefs.setInt('sessionTime' + uid, 0);
  }

// get time stored on local disk
  int getLocalTime(String name) {
    return prefs.getInt(name + uid) ?? 0;
  }

// increment time stored on local disk
  void incrementLocalTime(String name) {
    prefs.setInt(name + uid, (prefs.getInt(name + uid) ?? 0) + 1);
  }

// stop timer
  void cancel() {
    _timer?.cancel();
  }
}
