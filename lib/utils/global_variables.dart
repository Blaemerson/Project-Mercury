import 'package:projectmercury/models/contact.dart';

import '../models/message.dart';
import '../models/transaction.dart';

// Transactions
List<Transaction> initialTransactions = [
  Transaction(
    description: 'Initial Deposit',
    amount: 12000,
    timeStamp: DateTime.now(),
    state: TransactionState.approved,
  ),
];

Contact fillerContact = Contact(
  description: 'No information',
  name: 'Unknown',
  relationship: 'Stranger',
  photo:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/813px-Unknown_person.jpg?20200423155822',
  trustedWith: [],
);

List<Message> initialMessages = [
  Message(
    sender: fillerContact,
    text: 'Hi, can I have your social security number?',
    requestedItem: 'social security number',
  ),
];
