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
                  event.type == EventType.email
                      ? const Icon(Icons.email_outlined)
                      : Container(),
                  event.type == EventType.text
                      ? const Icon(Icons.textsms_outlined)
                      : Container(),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${formatDate.format(event.timeSent!)} (${timeAgo(event.timeSent!)})'),
                      Text(event.title),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Open'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
