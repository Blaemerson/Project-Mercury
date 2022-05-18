import 'package:flutter/material.dart';
import 'package:projectmercury/models/transaction.dart';

import '../utils/global_variables.dart';
import '../widgets/transaction_card.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  double _currentBalance = 0;

  @override
  void initState() {
    super.initState();
    calculateBalance();
  }

  void calculateBalance() {
    setState(() {
      for (var transact in transactions) {
        if (transact.state == transactionState.approved) {
          _currentBalance += transact.amount;
        }
      }
    });
  }

  updateBalance(double amount) {
    setState(() {
      _currentBalance += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                const Text(
                  'Account Balance:',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  formatCurrency.format(_currentBalance),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 8, bottom: 4),
            child: const Text(
              'Transactions:',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Flexible(
            child: Scrollbar(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionCard(
                    transaction: transactions.reversed.toList()[index],
                    updateFunction: updateBalance,
                  );
                },
                itemCount: transactions.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
