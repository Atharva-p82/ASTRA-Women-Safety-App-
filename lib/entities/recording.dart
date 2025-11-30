/// Model class for audio Recording entity
class Recording {
  /// URL to the audio recording (required)
  final String audioUrl;

  /// Duration in seconds (optional)
  final double? duration;

  /// Associated SOSAlert ID if applicable (optional)
  final String? alertId;

  /// Type of recording (required, enum)
  final RecordingType type;

  Recording({
    required this.audioUrl,
    this.duration,
    this.alertId,
    this.type = RecordingType.AlertRecording, // Default if not provided
  });

  /// Factory constructor to create Recording from JSON map
  factory Recording.fromJson(Map<String, dynamic> json) {
    return Recording(
      audioUrl: json['audio_url'],
      duration: (json['duration'] as num?)?.toDouble(),
      alertId: json['alert_id'],
      type: RecordingTypeExtension.fromString(json['type'] ?? "Alert Recording"),
    );
  }

  /// JSON serialization
  Map<String, dynamic> toJson() => {
        'audio_url': audioUrl,
        if (duration != null) 'duration': duration,
        if (alertId != null) 'alert_id': alertId,
        'type': type.value,
      };
}

/// Enum for allowed recording types
enum RecordingType {
  AlertRecording,
  ManualRecording,
}

extension RecordingTypeExtension on RecordingType {
  String get value {
    switch (this) {
      case RecordingType.AlertRecording:
        return "Alert Recording";
      case RecordingType.ManualRecording:
        return "Manual Recording";
    }
  }

  static RecordingType fromString(String value) {
    switch (value) {
      case "Alert Recording":
        return RecordingType.AlertRecording;
      case "Manual Recording":
        return RecordingType.ManualRecording;
      default:
        return RecordingType.AlertRecording;
    }
  }
}
