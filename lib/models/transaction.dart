import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionState {
  pending,
  actionNeeded,
  disputed,
  approved,
}

class Transaction {
  String id;
  final String description;
  final num amount;
  num overcharge;
  bool hidden;
  String? cloneId;
  DateTime? timeStamp;
  DateTime? timeActed;
  TransactionState state;
  String? linkedItemId;

  Transaction({
    this.id = '',
    required this.description,
    required this.amount,
    this.overcharge = 0,
    this.hidden = false,
    this.cloneId,
    this.timeStamp,
    this.timeActed,
    this.state = TransactionState.actionNeeded,
    this.linkedItemId,
  });

  Map<String, dynamic> toJson() {
    return ({
      'id': id,
      'description': description,
      'amount': amount,
      'overcharge': overcharge,
      'hidden': hidden,
      'cloneId': cloneId,
      'timeStamp': timeStamp,
      'timeActed': timeActed,
      'state': state.name,
      'linkedItemId': linkedItemId,
    });
  }

  factory Transaction.fromSnap(Map<String, dynamic> snap) {
    return Transaction(
      id: snap['id'],
      description: snap['description'],
      amount: snap['amount'],
      overcharge: snap['overcharge'] ?? 0,
      hidden: snap['hidden'] ?? false,
      cloneId: snap['cloneId'],
      timeStamp: snap['timeStamp'] != null
          ? (snap['timeStamp'] as Timestamp).toDate()
          : null,
      timeActed: snap['timeActed'] != null
          ? (snap['timeActed'] as Timestamp).toDate()
          : null,
      state: TransactionState.values.byName(snap['state']),
      linkedItemId: snap['linkedItemId'],
    );
  }
}
