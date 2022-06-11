import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectmercury/utils/global_variables.dart';

import 'contact.dart';

enum MessageState {
  static,
  actionNeeded,
  infoDenied,
  infoGiven,
}

class Message {
  final Contact sender;
  String id;
  final String text;
  String? requestedItem;
  DateTime? timeSent;
  DateTime? timeActed;
  MessageState state;
  int displayState;

  Message({
    required this.sender,
    this.id = '',
    required this.text,
    this.requestedItem,
    this.timeSent,
    this.timeActed,
    this.state = MessageState.actionNeeded,
    this.displayState = 0,
  });

  Map<String, dynamic> toJson() {
    return ({
      'sender': sender.toJson(),
      'id': id,
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
      sender: snap['sender'] != null
          ? Contact.fromSnap(snap['sender'] as Map<String, dynamic>)
          : fillerContact,
      id: snap['id'],
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
