import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/message.dart';
import '../models/transaction.dart';

var formatCurrency = NumberFormat.simpleCurrency();
var formatDate = DateFormat('yMMMMd');

// Transactions
List<Transaction> initialTransactions = [
  Transaction(
    id: const Uuid().v1(),
    description: 'Initial Deposit',
    amount: 12000,
    timeStamp: DateTime.now(),
    state: TransactionState.approved,
  ),
];

List<Message> initialMessages = [
  Message(
    id: const Uuid().v1(),
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    requestedItem: 'social security number',
    timeSent: DateTime.now(),
  ),
];
