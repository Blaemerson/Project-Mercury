import 'package:projectmercury/models/event.dart';

List<Event> events = [
  Event(
    timeSent: DateTime.now(),
    title: 'Sample Text Event',
    type: EventType.text,
  ),
  Event(
    timeSent: DateTime.now(),
    title: 'Sample Email Event',
    type: EventType.email,
  ),
];
