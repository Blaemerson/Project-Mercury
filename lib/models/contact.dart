class Contact {
  final String photo;
  final String name;
  final String relationship;
  final String description;
  final List<dynamic> trustedWith;

  Contact({
    required this.photo,
    required this.name,
    required this.relationship,
    required this.description,
    required this.trustedWith,
  });

  Map<String, dynamic> toJson() {
    return ({
      'photo': photo,
      'name': name,
      'relationship': relationship,
      'description': description,
      'trustedWith': trustedWith,
    });
  }

  static Contact fromSnap(Map<String, dynamic> snap) {
    return Contact(
      photo: snap['photo'],
      name: snap['name'],
      relationship: snap['relationship'],
      description: snap['description'],
      trustedWith: snap['trustedWith'],
    );
  }
}
