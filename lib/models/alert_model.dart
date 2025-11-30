class AlertModel {
  final String id;
  final String userId;
  final DateTime timestamp;
  final String status; // 'triggered', 'confirmed', 'false_alarm'
  final double? latitude;
  final double? longitude;

  AlertModel({
    required this.id,
    required this.userId,
    required this.timestamp,
    required this.status,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
      id: json['id'],
      userId: json['userId'],
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
