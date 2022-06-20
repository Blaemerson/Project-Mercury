class User {
  final String uid;
  String name;
  int score;
  num balance;
  int session;

  User({
    required this.uid,
    this.name = '',
    this.score = 0,
    this.balance = 0,
    this.session = 1,
  });

  Map<String, dynamic> toJson() {
    return ({
      'uid': uid,
      'name': name,
      'score': score,
      'balance': balance,
      'session': session,
    });
  }

  static User fromSnap(Map<String, dynamic> snap) {
    return User(
      uid: snap['uid'] ?? '',
      name: snap['name'] ?? '',
      score: snap['score'] ?? 0,
      balance: snap['balance'] ?? 0,
      session: snap['session'] ?? 1,
    );
  }
}
