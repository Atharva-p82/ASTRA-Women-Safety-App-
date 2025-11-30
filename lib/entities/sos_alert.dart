/// Model class for SOSAlert entity
class SOSAlert {
  /// Current status of the alert (required, default "Sent")
  final SOSAlertStatus status;
  
  /// Location where alert was triggered (optional)
  final Location? location;

  /// URL to audio recording proof (optional)
  final String? audioUrl;

  /// How the alert was triggered (optional)
  final SOSAlertTriggerType? triggerType;

  /// List of guardian IDs notified (optional)
  final List<String>? guardiansNotified;

  /// Additional context or notes (optional)
  final String? notes;

  SOSAlert({
    required this.status,
    this.location,
    this.audioUrl,
    this.triggerType,
    this.guardiansNotified,
    this.notes,
  });

  /// Factory to create SOSAlert from JSON map
  factory SOSAlert.fromJson(Map<String, dynamic> json) {
    return SOSAlert(
      status: SOSAlertStatusExtension.fromString(json['status'] ?? 'Sent'),
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
      audioUrl: json['audio_url'],
      triggerType: json['trigger_type'] != null
          ? SOSAlertTriggerTypeExtension.fromString(json['trigger_type'])
          : null,
      guardiansNotified: json['guardians_notified'] != null
          ? List<String>.from(json['guardians_notified'])
          : null,
      notes: json['notes'],
    );
  }

  /// JSON serialization
  Map<String, dynamic> toJson() => {
        'status': status.value,
        if (location != null) 'location': location!.toJson(),
        if (audioUrl != null) 'audio_url': audioUrl,
        if (triggerType != null) 'trigger_type': triggerType!.value,
        if (guardiansNotified != null) 'guardians_notified': guardiansNotified,
        if (notes != null) 'notes': notes,
      };
}

/// Enum for allowed SOSAlert status values
enum SOSAlertStatus {
  Sent,
  FalseAlarm,
  Resolved,
}

extension SOSAlertStatusExtension on SOSAlertStatus {
  String get value {
    switch (this) {
      case SOSAlertStatus.Sent:
        return "Sent";
      case SOSAlertStatus.FalseAlarm:
        return "False Alarm";
      case SOSAlertStatus.Resolved:
        return "Resolved";
    }
  }

  static SOSAlertStatus fromString(String value) {
    switch (value) {
      case "Sent":
        return SOSAlertStatus.Sent;
      case "False Alarm":
        return SOSAlertStatus.FalseAlarm;
      case "Resolved":
        return SOSAlertStatus.Resolved;
      default:
        return SOSAlertStatus.Sent;
    }
  }
}

/// Enum for allowed trigger types
enum SOSAlertTriggerType {
  AutomaticScreamDetected,
  AutomaticTriggerWord,
  ManualUserActivated,
}

extension SOSAlertTriggerTypeExtension on SOSAlertTriggerType {
  String get value {
    switch (this) {
      case SOSAlertTriggerType.AutomaticScreamDetected:
        return "Automatic - Scream Detected";
      case SOSAlertTriggerType.AutomaticTriggerWord:
        return "Automatic - Trigger Word";
      case SOSAlertTriggerType.ManualUserActivated:
        return "Manual - User Activated";
    }
  }

  static SOSAlertTriggerType fromString(String value) {
    switch (value) {
      case "Automatic - Scream Detected":
        return SOSAlertTriggerType.AutomaticScreamDetected;
      case "Automatic - Trigger Word":
        return SOSAlertTriggerType.AutomaticTriggerWord;
      case "Manual - User Activated":
        return SOSAlertTriggerType.ManualUserActivated;
      default:
        return SOSAlertTriggerType.ManualUserActivated;
    }
  }
}

/// Location data class
class Location {
  final double latitude;
  final double longitude;
  final String? address;

  Location({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        if (address != null) 'address': address,
      };
}
