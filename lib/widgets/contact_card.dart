import 'package:flutter/material.dart';

import '../models/contact.dart';

class ContactCard extends StatelessWidget {
  final Map<String, dynamic> snap;
  const ContactCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Contact contact = Contact.fromSnap(snap);

    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(contact.photo),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      contact.phoneNo,
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: '${contact.relationship}: ',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: contact.description,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
