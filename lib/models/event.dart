import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id;
  final String title;
  final String type;
  bool completed;
  DateTime? timeSent;
  DateTime? timeActed;

  Event({
    this.id = '',
    required this.title,
    required this.type,
    this.completed = false,
    this.timeSent,
    this.timeActed,
  });

  Map<String, dynamic> toJson() {
    return ({
      'id': id,
      'title': title,
      'type': type,
      'completed': completed,
      'timeSent': timeSent,
      'timeActed': timeActed,
    });
  }

  static Event fromSnap(Map<String, dynamic> snap) {
    return Event(
      id: snap['id'],
      title: snap['title'],
      type: snap['type'],
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
