import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionState {
  actionNeeded,
  disputed,
  approved,
}

class Transaction {
  final String description;
  final num amount;
  final DateTime timeStamp;
  TransactionState state;
  final String id;

  Transaction({
    required this.description,
    required this.amount,
    required this.timeStamp,
    this.state = TransactionState.actionNeeded,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return ({
      'description': description,
      'amount': amount,
      'timeStamp': timeStamp,
      'state': state.name,
      'id': id,
    });
  }

  factory Transaction.fromSnap(Map<String, dynamic> snap) {
    return Transaction(
      description: snap['description'],
      amount: snap['amount'],
      timeStamp: (snap['timeStamp'] as Timestamp).toDate(),
      state: TransactionState.values.byName(snap['state']),
      id: snap['id'],
    );
  }
}
