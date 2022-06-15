import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:projectmercury/pages/contactPage/contact_list.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/utils/global_variables.dart';

import 'locator.dart';

class EventController with ChangeNotifier {
  final FirestoreMethods _firestore = locator.get<FirestoreMethods>();
  final List<bool> _showBadge = [false, false, false, false, false];
  List<bool> get showBadge => _showBadge;

  void update() async {
    await _firestore.userTransaction.actionNeeded()
        ? _showBadge[1] = true
        : _showBadge[1] = false;
    await _firestore.userMessage.actionNeeded()
        ? _showBadge[3] = true
        : _showBadge[3] = false;
    notifyListeners();
    if (_showBadge[3] == false) {
      deployMessage();
    }
  }

  void deployMessage() async {
    int delay =
        Random().nextInt(messageMaxDelay - messageMinDelay) + messageMinDelay;
    int randomContact = Random().nextInt(contacts.length);
    Future.delayed(Duration(seconds: delay), () {
      _firestore.userMessage.add(initialMessages[0]);
    });
  }
}
