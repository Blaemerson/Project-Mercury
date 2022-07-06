import 'package:projectmercury/models/event.dart';

List<Event> events = [
  Event(
    timeSent: DateTime.now(),
    title: 'Sample Text Event',
    type: EventType.text,
    dialog: ['Can i have this information?', 'what is this'],
    question: 'Give Information?',
  ),
  Event(
    timeSent: DateTime.now(),
    title: 'Sample Email Event',
    type: EventType.email,
    dialog: [],
  ),
  Event(
    timeSent: DateTime.now(),
    title: 'Sample Call Event',
    type: EventType.call,
    dialog: [],
  ),
  Event(
      timeSent: DateTime.now(),
      title: "Neighbor's request",
      type: EventType.email,
      sender: 'neighbor',
      dialog: [
        'Hello, is may I have access to the front gate? I left my card in my room.'
      ],
      question: 'Give gate access to neighbor?'),
];
