import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectmercury/models/contact.dart';
import 'package:projectmercury/models/store_item.dart';

import '../models/message.dart';
import '../models/transaction.dart';
import '../pages/contacts_page.dart';
import '../pages/home_page.dart';
import '../pages/info_page.dart';
import '../pages/messages_page.dart';
import '../pages/money_page.dart';

var formatCurrency = NumberFormat.simpleCurrency();
var formatDate = DateFormat('yMMMMd');

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

// Pages
List<Widget> navBarPages = const [
  HomePage(),
  MoneyPage(),
  ContactsPage(),
  MessagesPage(),
  InfoPage(),
];

// Transactions
List<Transaction> transactions = [
  Transaction(
    description: 'Initial Deposit',
    amount: 12000,
    timeStamp: DateTime.now(),
    state: transactionState.approved,
  ),
  Transaction(
    description: 'Utility Bills',
    amount: -500,
    timeStamp: DateTime.now(),
    state: transactionState.actionNeeded,
  ),
  Transaction(
    description: 'Rent',
    amount: -2000,
    timeStamp: DateTime.now(),
    state: transactionState.actionNeeded,
  ),
  Transaction(
    description: 'Midterm Deposit',
    amount: 500,
    timeStamp: DateTime.now(),
    state: transactionState.approved,
  ),
  Transaction(
    description: 'TV Purchase',
    amount: -300,
    timeStamp: DateTime.now(),
    state: transactionState.actionNeeded,
  ),
  Transaction(
    description: 'Car Payment',
    amount: -1500,
    timeStamp: DateTime.now(),
    state: transactionState.actionNeeded,
  ),
  Transaction(
    description: 'Grocery',
    amount: -300,
    timeStamp: DateTime.now(),
    state: transactionState.actionNeeded,
  ),
  Transaction(
    description: 'Midterm Deposit',
    amount: 500,
    timeStamp: DateTime.now(),
    state: transactionState.approved,
  ),
];

List<Contact> contacts = [
  Contact(
    photo:
        'https://ph-files.imgix.net/6923e205-5ec7-4d11-b61d-5fae79915da9.png?auto=format&auto=compress&codec=mozjpeg&cs=strip',
    name: 'George Jenkins',
    phoneNo: '111-111-1111',
    relationship: 'Boss',
    description: 'trusted with work-related information',
    trustedWith: ['job infoformation'],
  ),
  Contact(
    photo:
        'https://nextbigwhat.com/wp-content/uploads/2019/02/AI-thispersondoesnotexist.jpg',
    name: 'Shelly Lambert',
    phoneNo: '222-222-2222',
    relationship: 'Best Friend',
    description: 'trusted with most information',
    trustedWith: ['most infoformation'],
  ),
  Contact(
    photo:
        'https://ph-files.imgix.net/c495260b-6e2b-4987-b44e-a669dce024c6.png?auto=format&auto=compress&codec=mozjpeg&cs=strip',
    name: 'Mathew Carpenter',
    phoneNo: '333-333-3333',
    relationship: 'Neighbor',
    description: 'trusted with some information',
    trustedWith: ['some infoformation'],
  ),
  Contact(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    phoneNo: '444-444-4444',
    relationship: 'scammer',
    description: 'trusted with nothing',
    trustedWith: [],
  ),
  Contact(
    photo:
        'https://preview.redd.it/ec87nearslg21.jpg?auto=webp&s=6cb832efd83e852174f7e54d1dbd2e673b87b955',
    name: 'Anna stone',
    phoneNo: '555-555-5555',
    relationship: 'Lawyer',
    description: 'trusted with everything',
    trustedWith: ['job infoformation'],
  ),
];

List<Message> messages = [
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
  Message(
    photo:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDMuZCURfJMSd76h_PCBbdYF2TgDZvlsQ_TQ&usqp=CAU',
    name: 'Lindsey Phillips',
    text: 'Hi, can I have your social security number?',
    request: 'social security number',
    timeSent: DateTime.now(),
  ),
];

List<StoreItem> storeItems = const [
  StoreItem(
    name: 'Bed 1',
    icon: Icon(Icons.bed),
    type: itemType.bed,
    price: 300.00,
  ),
  StoreItem(
    name: 'Bed 2',
    icon: Icon(Icons.bed),
    type: itemType.bed,
    price: 400.00,
  ),
  StoreItem(
    name: 'Bed 3',
    icon: Icon(Icons.bed),
    type: itemType.bed,
    price: 500.00,
  ),
];
