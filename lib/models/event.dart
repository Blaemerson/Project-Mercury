import 'package:cloud_firestore/cloud_firestore.dart';

enum EventType { text, email, call }

enum EventState { actionNeeded, rejected, approved }

class Event {
  String id;
  final int eventId;
  String sender;
  final String title;
  final EventType type;
  final List dialog;
  String question;
  bool? isScam;
  EventState state;
  String? audioPath;
  DateTime? timeSent;
  DateTime? timeActed;

  Event({
    this.id = '',
    required this.eventId,
    this.sender = 'unknown',
    required this.title,
    required this.type,
    required this.dialog,
    this.question = 'Give information?',
    this.isScam = false,
    this.state = EventState.actionNeeded,
    this.audioPath,
    this.timeSent,
    this.timeActed,
  });

  Map<String, dynamic> toJson() {
    return ({
      'id': id,
      'eventId': eventId,
      'sender': sender,
      'title': title,
      'type': type.name,
      'dialog': dialog,
      'question': question,
      'state': state.name,
      'audioPath': audioPath,
      'timeSent': timeSent,
      'timeActed': timeActed,
    });
  }

  static Event fromSnap(Map<String, dynamic> snap) {
    return Event(
      id: snap['id'],
      eventId: snap['eventId'],
      title: snap['title'],
      sender: snap['sender'],
      type: EventType.values.byName(snap['type']),
      dialog: snap['dialog'],
      question: snap['question'],
      state: EventState.values.byName(snap['state']),
      audioPath: snap['audioPath'],
      timeSent: snap['timeSent'] != null
          ? (snap['timeSent'] as Timestamp).toDate()
          : null,
      timeActed: snap['timeActed'] != null
          ? (snap['timeActed'] as Timestamp).toDate()
          : null,
    );
  }
}
