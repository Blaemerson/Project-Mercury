import 'package:projectmercury/models/event.dart';

List<Event> events = [
  Event(
    timeSent: DateTime.now(),
    title: 'Sample Text Event',
    type: EventType.text,
    dialog: [
      'We have detected suspicious activity on your network.',
      'Please send us your social security number asap to solve this issue.',
    ],
    question: 'Give social security number?',
  ),
  Event(
      timeSent: DateTime.now(),
      title: 'Sample Call Event',
      type: EventType.call,
      sender: 'Gail Galavant',
      dialog: [
        'Hello, we want to drop off a birthday cake at your house.',
        'Can you send us your address?'
      ],
      question: 'Give Gail your address?',
      audioPath: 'sampleCall.mp3'),
  Event(
      timeSent: DateTime.now(),
      title: "Sample Email Event",
      type: EventType.email,
      sender: 'neighbor',
      dialog: [
        'Hello, may I have access to the front gate? I left my card in my room and I can\'t get in.'
      ],
      question: 'Give gate access to neighbor?'),
];
