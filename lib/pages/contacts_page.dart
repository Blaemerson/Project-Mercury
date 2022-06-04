import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/contact.dart';
import '../widgets/contact_card.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Column(
        children: [
          Flexible(
            child: Scrollbar(
              child: Consumer<List<Contact>>(builder: (_, contacts, __) {
                return ListView.builder(
                  itemBuilder: (context, index) => ContactCard(
                    contact: contacts[index],
                  ),
                  itemCount: contacts.length,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
