import 'package:flutter/material.dart';
import 'package:projectmercury/utils/global_variables.dart';

import '../widgets/message_card.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return MessageCard(
                  message: messages[index],
                );
              },
              itemCount: messages.length,
            ),
          ),
        ],
      ),
    );
  }
}
