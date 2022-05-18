enum transactionState {
  actionNeeded,
  disputed,
  approved,
}

class Transaction {
  final String description;
  final double amount;
  final DateTime timeStamp;
  transactionState state;

  Transaction({
    required this.description,
    required this.amount,
    required this.timeStamp,
    this.state = transactionState.actionNeeded,
  });
}
