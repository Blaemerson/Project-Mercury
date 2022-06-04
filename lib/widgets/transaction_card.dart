import 'package:flutter/material.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';

import '../models/transaction.dart';
import '../utils/global_variables.dart';
import '../utils/utils.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    FirestoreMethods _firestore = locator.get<FirestoreMethods>();

// TODO: only add score when right decision made
    _approve() async {
      await _firestore.userTransaction
          .updateState(widget.transaction.id, TransactionState.approved);
      _firestore.user.updateScore(1);
    }

    _dispute() async {
      await _firestore.userTransaction
          .updateState(widget.transaction.id, TransactionState.disputed);
      _firestore.user.updateScore(1);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).colorScheme.onBackground,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatDate.format(widget.transaction.timeStamp),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.transaction.description,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    (widget.transaction.amount > 0 ? '+' : '') +
                        formatCurrency.format(widget.transaction.amount),
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
            ),
            widget.transaction.state == TransactionState.actionNeeded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          ElevatedButton.icon(
                              onPressed: () async {
                                bool result = await showConfirmation(
                                      context: context,
                                      title: 'Confirmation',
                                      text: 'Dispute this transaction?',
                                    ) ??
                                    false;
                                if (result == true) {
                                  _dispute();
                                }
                              },
                              icon: const Icon(Icons.close, size: 32),
                              label: const Text(
                                'Dispute',
                                style: TextStyle(fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[700],
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              bool result = await showConfirmation(
                                    context: context,
                                    title: 'Confirmation',
                                    text: 'Appove this transaction?',
                                  ) ??
                                  false;
                              if (result == true) {
                                _approve();
                              }
                            },
                            icon: const Icon(Icons.check, size: 36),
                            label: const Text(
                              'Approve',
                              style: TextStyle(fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : widget.transaction.state == TransactionState.approved
                    ? const Text(
                        'Approved',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      )
                    : const Text(
                        'Disputed',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
