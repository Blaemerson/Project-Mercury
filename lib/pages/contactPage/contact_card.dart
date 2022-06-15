import 'package:flutter/material.dart';
import 'package:projectmercury/utils/utils.dart';
import 'package:projectmercury/models/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  const ContactCard({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        child: Container(
          decoration: elevatedCardDecor(context),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage('assets/contacts/${contact.photo}'),
                          ),
                        ),
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
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
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
        onTap: () => showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                elevation: 3,
                child: Container(
                  height: 500,
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 240,
                          width: 240,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/contacts/${contact.photo}'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          contact.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '(${contact.relationship})',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const Divider(),
                        Text(
                          contact.description,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const Divider(),
                        Text(
                          'Trusted with: ${contact.trustedWith.join(', ')}',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
