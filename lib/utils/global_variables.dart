import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/message.dart';
import '../models/transaction.dart';

var formatCurrency = NumberFormat.simpleCurrency();
var formatDate = DateFormat('yMMMMd');

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}

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
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    requestedItem: 'social security number',
  ),
];
