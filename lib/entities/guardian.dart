/// Model class for a Guardian entity
class Guardian {
  /// Guardian's full name (required)
  final String name;

  /// Guardian's phone number with country code (required)
  final String phone;

  /// Relationship to user (required, must be one of allowed values)
  final GuardianRelationship relationship;

  /// Guardian's email address (optional)
  final String? email;

  Guardian({
    required this.name,
    required this.phone,
    required this.relationship,
    this.email,
  });

  /// Factory constructor to create Guardian from JSON map
  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      name: json['name'],
      phone: json['phone'],
      relationship: GuardianRelationshipExtension.fromString(json['relationship']),
      email: json['email'],
    );
  }

  /// JSON serialization
  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'relationship': relationship.value,
    if (email != null) 'email': email,
  };
}

/// Enum for allowed guardian relationships
enum GuardianRelationship {
  Parent,
  Sibling,
  Friend,
  Partner,
  Relative,
  Other,
}

/// Enum <-> String helpers
extension GuardianRelationshipExtension on GuardianRelationship {
  String get value {
    switch (this) {
      case GuardianRelationship.Parent: return "Parent";
      case GuardianRelationship.Sibling: return "Sibling";
      case GuardianRelationship.Friend: return "Friend";
      case GuardianRelationship.Partner: return "Partner";
      case GuardianRelationship.Relative: return "Relative";
      case GuardianRelationship.Other: return "Other";
    }
  }

  static GuardianRelationship fromString(String value) {
    switch (value) {
      case "Parent": return GuardianRelationship.Parent;
      case "Sibling": return GuardianRelationship.Sibling;
      case "Friend": return GuardianRelationship.Friend;
      case "Partner": return GuardianRelationship.Partner;
      case "Relative": return GuardianRelationship.Relative;
      default: return GuardianRelationship.Other;
    }
  }
}
