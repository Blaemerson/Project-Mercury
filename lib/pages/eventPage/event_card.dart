import 'package:flutter/material.dart';
import 'package:projectmercury/models/event.dart';
import 'package:projectmercury/utils/utils.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        decoration: elevatedCardDecor(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    event.type == EventType.email
                        ? Icons.email_outlined
                        : event.type == EventType.text
                            ? Icons.textsms_outlined
                            : event.type == EventType.call
                                ? Icons.call_outlined
                                : Icons.question_mark,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${event.type.name} from ${event.sender} (${timeAgo(event.timeSent!)})',
                          style: const TextStyle(fontSize: 12)),
                      Text(event.title, style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: event.type == EventType.text
                                          ? _TextEvent(event: event)
                                          : event.type == EventType.email
                                              ? _EmailEvent(event: event)
                                              : _CallEvent(event: event),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Divider(
                                        indent: 0,
                                      ),
                                      Text(
                                        event.question ?? '',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      yesOrNo(
                                        context,
                                        yesLabel: 'Approve',
                                        noLabel: 'Reject',
                                        yesConfirmationMessage: '',
                                        noConfirmationMessage: '',
                                        onYes: () {},
                                        onNo: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )));
                },
                child: const Text('Open'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextEvent extends StatelessWidget {
  final Event event;
  const _TextEvent({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            event.sender,
            style: const TextStyle(fontSize: 32),
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (String dialog in event.dialog) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Container(
                    decoration: elevatedCardDecor(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        dialog,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _EmailEvent extends StatelessWidget {
  final Event event;
  const _EmailEvent({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          event.title,
          style: const TextStyle(fontSize: 32),
        ),
        const Divider(),
        Text('From: ${event.sender}'),
        const Divider(),
        for (String dialog in event.dialog) ...[
          Text(
            dialog,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ],
    );
  }
}

class _CallEvent extends StatelessWidget {
  final Event event;
  const _CallEvent({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
