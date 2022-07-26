import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionState {
  pending,
  actionNeeded,
  disputed,
  approved,
}

class Transaction {
  final String id;
  final String description;
  final num amount;
  final DateTime? timeStamp;
  final DateTime? timeActed;
  final TransactionState state;
  final bool hidden;
  final String? linkedItemId;
  final String? cloneId;
  final bool isScam;
  final List<Transaction> deployOnDispute;
  final List<Transaction> deployOnResolved;

  Transaction({
    this.id = '',
    required this.description,
    required this.amount,
    this.hidden = false,
    this.state = TransactionState.actionNeeded,
    this.timeStamp,
    this.timeActed,
    this.cloneId,
    this.linkedItemId,
    this.isScam = false,
    this.deployOnDispute = const [],
    this.deployOnResolved = const [],
  });

  Map<String, dynamic> toJson() {
    return ({
      'id': id,
      'description': description,
      'amount': amount,
      'hidden': hidden,
      'state': state.name,
      'timeStamp': timeStamp,
      'timeActed': timeActed,
      'isScam': isScam,
      'cloneId': cloneId,
      'linkedItemId': linkedItemId,
      'deployOnDispute': listToJson(deployOnDispute),
      'deployOnResolved': listToJson(deployOnResolved),
    });
  }

  factory Transaction.fromSnap(Map<String, dynamic> snap) {
    List<Transaction> deployOnDispute = [];
    List<Transaction> deployOnResolved = [];
    for (Map<String, dynamic> transaction in snap['deployOnDispute']) {
      deployOnDispute.add(Transaction.fromSnap(transaction));
    }
    for (Map<String, dynamic> transaction in snap['deployOnResolved']) {
      deployOnResolved.add(Transaction.fromSnap(transaction));
    }
    return Transaction(
      id: snap['id'],
      description: snap['description'],
      amount: snap['amount'],
      hidden: snap['hidden'] ?? false,
      cloneId: snap['cloneId'],
      timeStamp: snap['timeStamp'] != null
          ? (snap['timeStamp'] as Timestamp).toDate()
          : null,
      timeActed: snap['timeActed'] != null
          ? (snap['timeActed'] as Timestamp).toDate()
          : null,
      state: TransactionState.values.byName(snap['state']),
      isScam: snap['isScam'] ?? false,
      linkedItemId: snap['linkedItemId'],
      deployOnDispute: deployOnDispute,
      deployOnResolved: deployOnResolved,
    );
  }

  List<Map<String, dynamic>> listToJson(List<Transaction> list) {
    List<Map<String, dynamic>> json = [];
    for (Transaction transaction in list) {
      json.add(transaction.toJson());
    }
    return json;
  }
}
