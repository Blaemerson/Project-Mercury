import 'package:cloud_firestore/cloud_firestore.dart';

enum EventType { text, email, call }

class Event {
  String id;
  String sender;
  final String title;
  final EventType type;
  final List<String> dialog;
  String question;
  bool? correctAnswer;
  bool completed;
  String? audioPath;
  DateTime? timeSent;
  DateTime? timeActed;

  Event({
    this.id = '',
    this.sender = 'unknown',
    required this.title,
    required this.type,
    required this.dialog,
    this.question = 'Give information?',
    this.completed = false,
    this.audioPath,
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
      'audioPath': audioPath,
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
