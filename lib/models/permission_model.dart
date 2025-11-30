class PermissionModel {
  final String id;
  final bool locationPermission;
  final bool microphonePermission;
  final bool cameraPermission;
  final DateTime lastUpdated;

  PermissionModel({
    required this.id,
    this.locationPermission = false,
    this.microphonePermission = false,
    this.cameraPermission = false,
    required this.lastUpdated,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'locationPermission': locationPermission,
      'microphonePermission': microphonePermission,
      'cameraPermission': cameraPermission,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      id: json['id'],
      locationPermission: json['locationPermission'] ?? false,
      microphonePermission: json['microphonePermission'] ?? false,
      cameraPermission: json['cameraPermission'] ?? false,
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  PermissionModel copyWith({
    String? id,
    bool? locationPermission,
    bool? microphonePermission,
    bool? cameraPermission,
    DateTime? lastUpdated,
  }) {
    return PermissionModel(
      id: id ?? this.id,
      locationPermission: locationPermission ?? this.locationPermission,
      microphonePermission: microphonePermission ?? this.microphonePermission,
      cameraPermission: cameraPermission ?? this.cameraPermission,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
