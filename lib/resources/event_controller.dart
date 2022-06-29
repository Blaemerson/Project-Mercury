import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:projectmercury/pages/messagePage/message_data.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/utils/global_variables.dart';

import 'locator.dart';

class EventController with ChangeNotifier {
  final FirestoreMethods _firestore = locator.get<FirestoreMethods>();
  int _session = 0;
  int nextSession() => _session++;
  int get session => _session;

  final List<bool> _showBadge = [false, false, false, false, false];
  List<bool> get showBadge => _showBadge;

  Future<void> update() async {
    await loadSession();
    await _firestore.waitingTransactionAction()
        ? _showBadge[1] = true
        : _showBadge[1] = false;
    await _firestore.waitingMessageAction()
        ? _showBadge[3] = true
        : _showBadge[3] = false;
    notifyListeners();
    if (_showBadge[3] == false) {
      deployMessage();
    }
  }

  Future<void> loadSession() async {
    _session = await _firestore.userFuture.then((value) => value.session);
  }

  void deployMessage() async {
    int delay =
        Random().nextInt(messageMaxDelay - messageMinDelay) + messageMinDelay;
    Future.delayed(Duration(seconds: delay), () {
      _firestore.addMessage(randomMessage);
    });
  }
}
