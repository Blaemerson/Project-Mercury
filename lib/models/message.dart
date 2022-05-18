enum messageState {
  actionNeeded,
  infoDenied,
  infoGiven,
}

class Message {
  final String photo;
  final String name;
  final String text;
  final String request;
  final DateTime timeSent;
  DateTime? timeActed;
  messageState state;

  Message({
    required this.photo,
    required this.name,
    required this.text,
    required this.request,
    required this.timeSent,
    this.timeActed,
    this.state = messageState.actionNeeded,
  });
}
