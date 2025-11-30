// enum GuardianRelationship {
//   parent,
//   sibling,
//   friend,
//   partner,
//   relative,
//   other,
// }

// extension GuardianRelationshipExtension on GuardianRelationship {
//   String get displayName {
//     switch (this) {
//       case GuardianRelationship.parent:
//         return 'Parent';
//       case GuardianRelationship.sibling:
//         return 'Sibling';
//       case GuardianRelationship.friend:
//         return 'Friend';
//       case GuardianRelationship.partner:
//         return 'Partner';
//       case GuardianRelationship.relative:
//         return 'Relative';
//       case GuardianRelationship.other:
//         return 'Other';
//     }
//   }

//   static GuardianRelationship fromString(String value) {
//     switch (value.toLowerCase()) {
//       case 'parent':
//         return GuardianRelationship.parent;
//       case 'sibling':
//         return GuardianRelationship.sibling;
//       case 'friend':
//         return GuardianRelationship.friend;
//       case 'partner':
//         return GuardianRelationship.partner;
//       case 'relative':
//         return GuardianRelationship.relative;
//       case 'other':
//         return GuardianRelationship.other;
//       default:
//         return GuardianRelationship.friend;
//     }
//   }
// }

// class Guardian {
//   final String id;
//   final String name;
//   final String phone;
//   final String? email;
//   final GuardianRelationship relationship;
//   final DateTime createdAt;

//   Guardian({
//     required this.id,
//     required this.name,
//     required this.phone,
//     this.email,
//     required this.relationship,
//     required this.createdAt,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'phone': phone,
//       'email': email,
//       'relationship': relationship.displayName,
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }

//   factory Guardian.fromJson(Map<String, dynamic> json) {
//     return Guardian(
//       id: json['id'],
//       name: json['name'],
//       phone: json['phone'],
//       email: json['email'],
//       relationship: GuardianRelationshipExtension.fromString(
//         json['relationship'] ?? 'friend',
//       ),
//       createdAt: DateTime.parse(json['createdAt']),
//     );
//   }

//   Guardian copyWith({
//     String? id,
//     String? name,
//     String? phone,
//     String? email,
//     GuardianRelationship? relationship,
//     DateTime? createdAt,
//   }) {
//     return Guardian(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       phone: phone ?? this.phone,
//       email: email ?? this.email,
//       relationship: relationship ?? this.relationship,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }


enum GuardianRelationship { friend, family, colleague }

extension GuardianRelationshipExtension on GuardianRelationship {
  String get displayName {
    switch (this) {
      case GuardianRelationship.friend:
        return "Friend";
      case GuardianRelationship.family:
        return "Family";
      case GuardianRelationship.colleague:
        return "Colleague";
    }
  }
}

class Guardian {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final GuardianRelationship relationship;
  final DateTime createdAt;

  Guardian({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.relationship,
    required this.createdAt,
  });

  // Convert Firestore doc -> Guardian
  factory Guardian.fromMap(Map<String, dynamic> map, String docId) {
    return Guardian(
      id: docId,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'],
      relationship: GuardianRelationship.values[map['relationship'] ?? 0],
      createdAt: (map['createdAt'] as dynamic).toDate() ?? DateTime.now(),
    );
  }

  // Convert Guardian -> Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'relationship': relationship.index,
      'createdAt': createdAt,
    };
  }

  // Optional: copyWith to easily update
  Guardian copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    GuardianRelationship? relationship,
    DateTime? createdAt,
  }) {
    return Guardian(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      relationship: relationship ?? this.relationship,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
