import 'package:cloud_firestore/cloud_firestore.dart';

enum EventType { text, email }

class Event {
  String id;
  String sender;
  final String title;
  final EventType type;
  final String dialog;
  String? question;
  bool? correctAnswer;
  bool completed;
  DateTime? timeSent;
  DateTime? timeActed;

  Event({
    this.id = '',
    this.sender = '',
    required this.title,
    required this.type,
    this.dialog = '',
    this.question,
    this.completed = false,
    this.timeSent,
    this.timeActed,
  });

  Map<String, dynamic> toJson() {
    return ({
      'id': id,
      'title': title,
      'type': type.name,
      'dialog': dialog,
      'question': question,
      'completed': completed,
      'timeSent': timeSent,
      'timeActed': timeActed,
    });
  }

  static Event fromSnap(Map<String, dynamic> snap) {
    return Event(
      id: snap['id'],
      title: snap['title'],
      type: EventType.values.byName(snap['type']),
      dialog: snap['dialog'],
      question: snap['question'],
      completed: snap['completed'],
      timeSent: snap['timeSent'] != null
          ? (snap['timeSent'] as Timestamp).toDate()
          : null,
      timeActed: snap['timeActed'] != null
          ? (snap['timeActed'] as Timestamp).toDate()
          : null,
    );
  }
}
