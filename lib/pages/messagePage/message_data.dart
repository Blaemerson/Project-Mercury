import 'dart:math';

import 'package:projectmercury/models/contact.dart';
import 'package:projectmercury/models/message.dart';
import 'package:projectmercury/pages/contactPage/contact_data.dart';

List<Message> messages = [
  Message(
    sender: contacts[0],
    text: 'Hi, can I have your social security number?',
    requestedItem: 'social security number',
  ),
  Message(
    sender: contacts[0],
    text: 'Hi, can I have your address?',
    requestedItem: 'address',
  ),
  Message(
    sender: contacts[0],
    text: 'Hi, can I have your phone number?',
    requestedItem: 'phone number',
  )
];

Message get randomMessage {
  Contact contact = contacts.elementAt(
    Random().nextInt(contacts.length),
  );
  String info = shareableInfo.keys.elementAt(
    Random().nextInt(shareableInfo.length),
  );
  return Message(
    sender: contact,
    text: "Hello, can I have your $info?",
    requestedItem: info,
  );
}
