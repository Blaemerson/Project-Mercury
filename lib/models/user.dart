class User {
  final String uid;
  final String displayName;
  int totalScore;

  User({
    required this.uid,
    required this.displayName,
    this.totalScore = 0,
  });

  addToScore(int score) {
    totalScore += score;
  }
}
