import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projectmercury/models/transaction.dart' as model;
import 'package:projectmercury/models/user.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';
import 'package:projectmercury/utils/utils.dart';
import 'transaction_card.dart';

class MoneyPage extends StatefulWidget {
  const MoneyPage({Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    FirestoreMethods _firestore = locator.get<FirestoreMethods>();

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
                StreamBuilder<User>(
                  stream: _firestore.userStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        formatCurrency.format(snapshot.data!.balance),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return Text(
                      formatCurrency.format(0),
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
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
          Flexible(
            child: Scrollbar(
              child: FirestoreListView<model.Transaction>(
                query: _firestore.transactionQuery,
                itemBuilder: (context, snapshot) {
                  model.Transaction transaction = snapshot.data();
                  return TransactionCard(transaction: transaction);
                },
                pageSize: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
