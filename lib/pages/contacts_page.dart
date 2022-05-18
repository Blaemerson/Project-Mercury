import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/utils/global_variables.dart';

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
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('contacts')
                      .orderBy('name')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) => ContactCard(
                        snap: snapshot.data!.docs[index].data(),
                      ),
                      itemCount: snapshot.data!.docs.length,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
