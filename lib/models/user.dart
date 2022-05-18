class User {
  final String uid;
  final String email;
  int totalScore;

  User({
    required this.uid,
    required this.email,
    required this.totalScore,
  });

  addToScore(int score) {
    totalScore += score;
  }
}
