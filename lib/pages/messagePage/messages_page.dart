import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:projectmercury/resources/firestore_methods.dart';

import '../../models/message.dart';
import '../../resources/locator.dart';
import 'message_card.dart';

//TODO: replace this page with event page when finished
class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

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
              query: _firestore.messageQuery,
              itemBuilder: (context, snapshot) {
                Message message = snapshot.data();
                return MessageCard(message: message);
              },
              pageSize: 2,
              reverse: true,
            ),
          ),
        ],
      ),
    );
  }
}
