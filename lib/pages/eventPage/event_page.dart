import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projectmercury/models/event.dart';
import 'package:projectmercury/pages/eventPage/event_card.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirestoreMethods _firestore = locator.get<FirestoreMethods>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Column(
        children: [
          Flexible(
            child: FirestoreListView<Event>(
              query: _firestore.eventQuery,
              itemBuilder: (context, snapshot) {
                Event event = snapshot.data();
                return EventCard(event: event);
              },
              pageSize: 3,
            ),
          ),
        ],
      ),
    );
  }
}
