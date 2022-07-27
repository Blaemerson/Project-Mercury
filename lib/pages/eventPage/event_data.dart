import 'package:projectmercury/models/event.dart';

// The 3rd digit of eventId is the session in which they will be deployed
List<Event> events = [
  Event(
    eventId: 100,
    sender: 'Accountant',
    title: 'Request for SSN',
    type: EventType.email,
    dialog: [
      "Hello, I am your accountant hare at finance global. I am working on your tax returns and it seems that your SSN is not on file. Would you be willing to send over your SSN througn our secure link?"
    ],
    question: 'Send social security number?',
    isScam: false,
  ),
  Event(
    eventId: 101,
    sender: 'Accountant',
    title: 'Request for SSN',
    type: EventType.call,
    dialog: [
      "Hello, your forgot to send your social security number to me for your taxes. Please text me your social security number right away or else there will be penalties and fines."
    ],
    question: 'Send social security number?',
    isScam: true,
    audioPath: '101.wav',
  ),
  Event(
    eventId: 102,
    sender: "Accountant",
    title: 'Bank Info Request',
    type: EventType.email,
    dialog: [
      "Hello, I am currently examining a pending purchase on your most recent audit. Would you be willing to assist me in examining the charges on your account to check fraudulent activity?"
    ],
    question: 'Send bank account information?',
  ),
  Event(
    eventId: 103,
    title: 'Bank Info Request',
    type: EventType.text,
    dialog: [
      "THERE HAS BEEN A BAD CHARGE ON YOUR ACCOUNT.",
      "TEXT BACK YOUR BANK ACCOUNT INFORMATION TO FIX THE ISSUES.",
    ],
    question: 'Send bank account information?',
    isScam: true,
  ),
  Event(
      eventId: 104,
      sender: 'Automania',
      title: 'Car Recall Notice',
      type: EventType.call,
      dialog: [
        "Hello, this is Automania dealership. We found that your car has a potential recall depending on the production date of your vehicle. When convenient, cound your send us your vehicle's VIN number to ensure that you do or do not qualify for a needed recall. Thank you and have a great day.",
      ],
      question: 'Send VIN number?',
      audioPath: '104.wav'),
  Event(
    eventId: 105,
    title: 'Extended Car Warranty',
    type: EventType.call,
    dialog: [
      "Your car's extended warranty is expiring soon and you will not have a chance to extend this beyond the termination date. Please call back and give out team the needed information to extend your warranty.",
    ],
    question: 'Send information?',
    isScam: true,
    audioPath: '105.wav',
  ),
  Event(
    eventId: 200,
    title: 'Jury Duty Selection',
    type: EventType.text,
    dialog: [
      "Hello, you have not attended your selection for jury duty. This attendance is required by law. Your failure to attend has resulted in a fine deing assigned to you.",
      "Please click this LINK to submit your fine payment. Failure to do so will result in interest fees being added."
    ],
    question: 'Click on the link?',
    isScam: true,
  ),
  Event(
    eventId: 201,
    sender: 'GYM USA',
    title: 'Gym Membership',
    type: EventType.text,
    dialog: [
      "GYM USA: Did someone say PRIZES?! Yes! You could win AMAZING prizes by joining the GYM USA Summer Bucket List. Just Text back SUMMER to 844-889-6222!\n\nTxt STOP to OptOut"
    ],
    question: 'Text "SUMMER"?',
    isScam: true,
  ),
  Event(
    eventId: 202,
    sender: 'John',
    title: 'Property Info',
    type: EventType.text,
    dialog: [
      "Hey, this is John from Neighborhood Loans. I believe hearing somebocy else edify you is more impactful that you speaking highly of yourself. This is why we ask for referrals 6 times during the transaction on behalf of the agent representing the buyer.",
      "Check out the link above and let me know if you would like to discuss in more detail.",
    ],
    question: 'Click on the link?',
    isScam: true,
  ),
  Event(
    eventId: 203,
    title: 'Package Shipped',
    type: EventType.email,
    dialog: [
      "Hello, your recent purchase is taking longer than expected because of the additional shipping costs to arrive at your home.",
      "In order to receive your package, you must submit the additional shipping cost before end of day today or else the package will be sent back to the warehouse."
    ],
    question: 'Send additional payment?',
    isScam: true,
  ),
];
