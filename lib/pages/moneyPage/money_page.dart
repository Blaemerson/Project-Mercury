import 'package:flutter/material.dart';
import 'package:projectmercury/models/transaction.dart';
import 'package:projectmercury/resources/event_controller.dart';
import 'package:projectmercury/utils/utils.dart';
import 'package:provider/provider.dart';
import 'transaction_card.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Consumer<EventController>(
                  builder: (_, event, __) {
                    return Text(
                      formatCurrency.format(event.balance),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
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
          Consumer<EventController>(builder: (_, event, __) {
            List<Transaction> visibleTransactions = event.transactions
                .where((element) => element.hidden == false)
                .toList();
            return Flexible(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: visibleTransactions.length,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                        transaction: visibleTransactions[index]);
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
