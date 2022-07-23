import 'package:flutter/cupertino.dart';

import '../models/transaction.dart';

//Event setting
const int eventMaxDelay = 30; //seconds
const int eventMinDelay = 10; //seconds

// Transactions
Transaction initialTransaction = Transaction(
  description: 'Initial Deposit',
  amount: 12000,
  timeStamp: DateTime.now(),
  state: TransactionState.approved,
);

final homeKey = GlobalKey();
