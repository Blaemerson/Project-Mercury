import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:provider/provider.dart';

import '../models/message.dart';
import '../resources/locator.dart';
import '../widgets/message_card.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirestoreMethods _firestore = locator.get<FirestoreMethods>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Column(
        children: [
          Flexible(
            child: FirestoreListView<Message>(
              query: _firestore.userMessage.query,
              itemBuilder: (context, snapshot) {
                Message message = snapshot.data();
                return MessageCard(message: message);
              },
              pageSize: 2,
              reverse: true,
            ),
            // Consumer<List<Message>>(
            //   builder: (_, messages, __) {
            //     return ListView.builder(
            //       reverse: true,
            //       itemBuilder: (context, index) {
            //         return MessageCard(
            //           message: messages[index],
            //         );
            //       },
            //       itemCount: messages.length,
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
