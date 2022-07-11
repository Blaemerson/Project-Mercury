import '../models/transaction.dart';

//Transaction setting
const bool randomOvercharge = false;
const double overchargeFrequency = 0.5;
const int maxOvercharge = 30; // * 10
const int minOvercharge = 1; // * 10

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
