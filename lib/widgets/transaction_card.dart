import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../utils/global_variables.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  final ValueChanged<double> updateFunction;
  const TransactionCard({
    Key? key,
    required this.transaction,
    required this.updateFunction,
  }) : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            widget.transaction.state == transactionState.actionNeeded
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  'Confirmation',
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                content: const Text(
                                  'Dispute this transaction?',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        widget.transaction.state =
                                            transactionState.disputed;
                                      });
                                    },
                                    child: const Text(
                                      'Dispute',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            icon: const Icon(Icons.cancel),
                            iconSize: 50,
                            color: Colors.red,
                            padding: const EdgeInsets.all(8),
                          ),
                          const Text(
                            'Dispute',
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  'Confirmation',
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                content: const Text(
                                  'Approve this transaction?',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        widget.transaction.state =
                                            transactionState.approved;
                                        widget.updateFunction(
                                          widget.transaction.amount,
                                        );
                                      });
                                    },
                                    child: const Text(
                                      'Approve',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            icon: const Icon(Icons.check_circle),
                            iconSize: 50,
                            color: Colors.green,
                            padding: const EdgeInsets.all(8),
                          ),
                          const Text(
                            'Approve',
                            style: TextStyle(fontSize: 20, color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  )
                : widget.transaction.state == transactionState.approved
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
