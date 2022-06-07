import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message.dart';
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
          // TODO: remove when done
          const Text(
            '*Notice: message below resets after 3 seconds for testing*',
            style: TextStyle(fontSize: 24),
          ),
          Flexible(
            child: Consumer<List<Message>>(
              builder: (_, messages, __) {
                return ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) {
                    return MessageCard(
                      message: messages[index],
                    );
                  },
                  itemCount: messages.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
