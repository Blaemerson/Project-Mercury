import 'package:flutter/material.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';

import '../models/message.dart';
import '../utils/utils.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirestoreMethods _firestore = locator.get<FirestoreMethods>();
// TODO: only add score when right decision made
    _give() async {
      await _firestore.userMessage
          .updateState(message.id, MessageState.infoGiven);
      _firestore.user.updateScore(1);
    }

    _deny() async {
      await _firestore.userMessage
          .updateState(message.id, MessageState.infoDenied);
      _firestore.user.updateScore(1);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Column(
        children: [
          _chatBubble(message.text, false, context),
          const SizedBox(height: 12),
          if (message.state == MessageState.actionNeeded) ...[
            Text(
              'Give *${message.requestedItem}* to ${message.name}?',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    bool result = await showConfirmation(
                          context: context,
                          title: 'Confirmation',
                          text: "Deny ${message.name}'s request?",
                        ) ??
                        false;
                    if (result == true) {
                      _deny();
                    }
                  },
                  icon: const Icon(Icons.close, size: 32),
                  label: const Text(
                    'No',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[700],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    bool result = await showConfirmation(
                          context: context,
                          title: 'Confirmation',
                          text: 'Give information to ${message.name}?',
                        ) ??
                        false;
                    if (result == true) {
                      _give();
                    }
                  },
                  icon: const Icon(Icons.check, size: 36),
                  label: const Text(
                    'Yes',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[700],
                  ),
                ),
              ],
            ),
          ] else if (message.state != MessageState.static) ...[
            if (message.displayState > 0) ...[
              message.state == MessageState.infoGiven
                  ? _chatBubble("My ${message.requestedItem} is ***-**-****",
                      true, context)
                  : _chatBubble("You can't have my ${message.requestedItem}",
                      true, context),
              const SizedBox(height: 12),
            ],
            if (message.displayState > 1) ...[
              message.state == MessageState.infoGiven
                  ? _chatBubble('Thank you!', false, context)
                  : _chatBubble(':(', false, context)
            ],
          ],
        ],
      ),
    );
  }

  Row _chatBubble(String text, bool you, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        you
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(message.photo),
                ),
              ),
        Expanded(
          child: Padding(
            padding: you
                ? const EdgeInsets.only(left: 100)
                : const EdgeInsets.only(right: 100),
            child: Column(
              crossAxisAlignment:
                  you ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${you ? 'You' : message.name}:',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: elevatedCardDecor(context),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
