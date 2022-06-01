class User {
  final String uid;
  String name;
  int score;
  double balance;

  User({
    required this.uid,
    this.name = '',
    this.score = 0,
    this.balance = 0,
  });

  Map<String, dynamic> toJson() {
    return ({
      'uid': uid,
      'name': name,
      'score': score,
      'balance': balance,
    });
  }

  static User fromSnap(Map<String, dynamic> snap) {
    return User(
      uid: snap['uid'],
      name: snap['name'],
      score: snap['score'],
      balance: snap['balance'],
    );
  }
}
