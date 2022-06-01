import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/message.dart';
import '../models/transaction.dart';

var formatCurrency = NumberFormat.simpleCurrency();
var formatDate = DateFormat('yMMMMd');

// Transactions
List<Transaction> initialTransactions = [
  Transaction(
    description: 'Initial Deposit',
    amount: 12000,
    timeStamp: DateTime.now(),
    state: TransactionState.approved,
    id: const Uuid().v1(),
  ),
];

List<Message> messages = [
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
];
