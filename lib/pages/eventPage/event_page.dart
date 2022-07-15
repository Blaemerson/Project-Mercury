import 'package:flutter/material.dart';
import 'package:projectmercury/pages/eventPage/event_card.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:provider/provider.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Column(
        children: [
          Consumer<EventController>(
            builder: (_, event, __) {
              return Flexible(
                child: ListView.builder(
                  itemCount: event.deployedEvents.length,
                  itemBuilder: (context, index) {
                    return EventCard(event: event.deployedEvents[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
