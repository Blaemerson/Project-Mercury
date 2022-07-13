import 'package:flutter/cupertino.dart';
import 'package:projectmercury/models/event.dart';
import 'package:projectmercury/pages/eventPage/event_data.dart';
import 'package:projectmercury/resources/firestore_methods.dart';

import 'locator.dart';

class EventController with ChangeNotifier {
  final FirestoreMethods _firestore = locator.get<FirestoreMethods>();
  int _session = 0;
  int get session => _session;
  int nextSession() => _session++;

  final List<bool> _showBadge = [false, false, false, false, false];
  List<bool> get showBadge => _showBadge;

  List<Event> deployableEvents = events;

  Future<void> update() async {
    await loadSession();
    await _firestore.waitingTransactionAction()
        ? _showBadge[1] = true
        : _showBadge[1] = false;
    await _firestore.waitingEventAction()
        ? _showBadge[3] = true
        : _showBadge[3] = false;
    notifyListeners();
    if (_showBadge[3] == false) {
      deployEvent();
    }
  }

  Future<void> loadSession() async {
    _session = await _firestore.userFuture.then((value) => value.session);
  }

  Future<void> deployEvent() async {
    List<Event> deployable = [...deployableEvents];
    for (Event event in await _firestore.eventsFuture) {
      deployable.removeWhere((data) => data.eventId == event.eventId);
    }
    deployable.isNotEmpty
        ? Future.delayed(
            Duration(
                seconds: /*Random().nextInt(eventMaxDelay - eventMinDelay) +
                    eventMinDelay*/
                    0),
            (() => _firestore.addEvent(deployable.first)),
          )
        : null;
  }
}
