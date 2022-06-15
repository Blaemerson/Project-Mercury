import 'package:projectmercury/models/contact.dart';

Map<String, String> shareableInfo = {
  'social security number': '123-45-6789',
  'address': '123 Vestify St.',
  'phone number': '903-123-4567'
};

const Contact tempContact = Contact(
  photo: 'unknown.jpg',
  name: 'Unknown',
  relationship: 'Stranger',
  description: 'No information',
  trustedWith: [],
);

const List<Contact> contacts = [
  Contact(
    photo: 'anna_stone.jpg',
    name: 'Anna Stone',
    relationship: 'Lawyer',
    description: 'Trusted with everything',
    trustedWith: [
      'social security number',
      'address',
      'phone number',
    ],
  ),
  Contact(
    photo: 'mathew_carpenter.jpg',
    name: 'Mathew Carpenter',
    relationship: 'Neighbor',
    description: 'Trusted with some information',
    trustedWith: ['address', 'phone number'],
  ),
  Contact(
    photo: 'george_jenkins.jpg',
    name: 'George Jenkins',
    relationship: 'Boss',
    description: 'Trusted with job information',
    trustedWith: [
      'address',
      'social security number',
      'phone number',
    ],
  ),
  Contact(
    photo: 'lindsey_phillips.jpg',
    name: 'Lindsey Phillips',
    relationship: 'Scammer',
    description: 'Trusted with no information',
    trustedWith: [],
  ),
  Contact(
    photo: 'shelly_lambert.jpg',
    name: 'Shelly Lambert',
    relationship: 'Best Friend',
    description: 'Trusted with most information',
    trustedWith: ['address', 'phone number'],
  ),
];
