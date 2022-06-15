import 'package:projectmercury/models/contact.dart';
import 'package:projectmercury/pages/contactPage/contact_data.dart';

import '../models/message.dart';
import '../models/transaction.dart';

//Transaction setting
const double overchargeFrequency = 0.5;
const int maxOvercharge = 30; // * 10
const int minOvercharge = 1; // * 10

//Message setting
const int messageMaxDelay = 30; //seconds
const int messageMinDelay = 10; //seconds

// Transactions
Transaction initialTransaction = Transaction(
  description: 'Initial Deposit',
  amount: 12000,
  timeStamp: DateTime.now(),
  state: TransactionState.approved,
);
