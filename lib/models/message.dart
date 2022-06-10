import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageState {
  static,
  actionNeeded,
  infoDenied,
  infoGiven,
}

class Message {
  String id;
  final String photo;
  final String name;
  final String text;
  String? requestedItem;
  DateTime? timeSent;
  DateTime? timeActed;
  MessageState state;
  int displayState;

  Message({
    this.id = '',
    required this.photo,
    required this.name,
    required this.text,
    this.requestedItem,
    this.timeSent,
    this.timeActed,
    this.state = MessageState.actionNeeded,
    this.displayState = 0,
  });

  Map<String, dynamic> toJson() {
    return ({
      'id': id,
      'photo': photo,
      'name': name,
      'text': text,
      'requestedItem': requestedItem,
      'timeSent': timeSent,
      'timeActed': timeActed,
      'state': state.name,
      'displayState': displayState,
    });
  }

  static Message fromSnap(Map<String, dynamic> snap) {
    return Message(
      id: snap['id'],
      photo: snap['photo'],
      name: snap['name'],
      text: snap['text'],
      requestedItem: snap['requestedItem'],
      timeSent: snap['timeSent'] != null
          ? (snap['timeSent'] as Timestamp).toDate()
          : null,
      timeActed: snap['timeActed'] != null
          ? (snap['timeActed'] as Timestamp).toDate()
          : null,
      state: MessageState.values.byName(snap['state']),
      displayState: snap['displayState'],
    );
  }
}
