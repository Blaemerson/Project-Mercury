import 'package:projectmercury/models/contact.dart';

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
    trustedWith: [],
  ),
  Contact(
    photo: 'mathew_carpenter.jpg',
    name: 'Mathew Carpenter',
    relationship: 'Neighbor',
    description: 'Trusted with some information',
    trustedWith: [],
  ),
  Contact(
    photo: 'george_jenkins.jpg',
    name: 'George Jenkins',
    relationship: 'Boss',
    description: 'Trusted with job information',
    trustedWith: [],
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
    trustedWith: [],
  ),
];
