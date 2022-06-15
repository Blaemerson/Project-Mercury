import 'package:projectmercury/pages/contactPage/contact_list.dart';

class Contact {
  final String photo;
  final String name;
  final String relationship;
  final String description;
  final List<dynamic> trustedWith;

  const Contact({
    required this.photo,
    required this.name,
    required this.relationship,
    required this.description,
    required this.trustedWith,
  });

  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'relationship': relationship,
      'trustedWith': trustedWith,
    });
  }

  static Contact fromSnap(Map<String, dynamic> snap) {
    return contacts.firstWhere((contact) => contact.name == snap['name'],
        orElse: () => tempContact);

    // Contact(
    //   photo: snap['photo'],
    //   name: snap['name'],
    //   relationship: snap['relationship'],
    //   description: snap['description'],
    //   trustedWith: snap['trustedWith'],
    // );
  }
}
