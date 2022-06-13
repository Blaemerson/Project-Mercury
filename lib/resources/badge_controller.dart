import 'package:flutter/cupertino.dart';
import 'package:projectmercury/resources/firestore_methods.dart';

import 'locator.dart';

class BadgeController with ChangeNotifier {
  final FirestoreMethods _firestore = locator.get<FirestoreMethods>();
  final List<bool> _showBadge = [false, false, false, false, false];
  List<bool> get showBadge => _showBadge;

  void initialize() {}

  void update() async {
    await _firestore.userTransaction.actionNeeded()
        ? _showBadge[1] = true
        : _showBadge[1] = false;
    await _firestore.userMessage.actionNeeded()
        ? _showBadge[3] = true
        : _showBadge[3] = false;
    notifyListeners();
  }
}
