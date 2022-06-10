import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionState {
  actionNeeded,
  disputed,
  approved,
}

class Transaction {
  String id;
  final String description;
  final num amount;
  DateTime? timeStamp;
  DateTime? timeActed;
  TransactionState state;

  Transaction({
    this.id = '',
    required this.description,
    required this.amount,
    this.timeStamp,
    this.timeActed,
    this.state = TransactionState.actionNeeded,
  });

  Map<String, dynamic> toJson() {
    return ({
      'id': id,
      'description': description,
      'amount': amount,
      'timeStamp': timeStamp,
      'timeActed': timeActed,
      'state': state.name,
    });
  }

  factory Transaction.fromSnap(Map<String, dynamic> snap) {
    return Transaction(
      id: snap['id'],
      description: snap['description'],
      amount: snap['amount'],
      timeStamp: snap['timeStamp'] != null
          ? (snap['timeStamp'] as Timestamp).toDate()
          : null,
      timeActed: snap['timeActed'] != null
          ? (snap['timeActed'] as Timestamp).toDate()
          : null,
      state: TransactionState.values.byName(snap['state']),
    );
  }
}
