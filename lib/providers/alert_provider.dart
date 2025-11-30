import 'package:flutter/material.dart';

// Alert Model for notifications
class AlertModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String type; // 'sos', 'guardian_alert', 'system', 'voice'

  AlertModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    required this.type,
  });

  // Create a copy with modifications
  AlertModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    bool? isRead,
    String? type,
  }) {
    return AlertModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }
}

class AlertProvider extends ChangeNotifier {
  // Voice activation properties
  bool _isListening = false;
  int _timerSeconds = 15;
  bool _alertTriggered = false;

  // Notifications list
  List<AlertModel> _alerts = [];

  // Getters for voice activation
  bool get isListening => _isListening;
  int get timerSeconds => _timerSeconds;
  bool get alertTriggered => _alertTriggered;
  bool? get isAlertModeOn => _alertTriggered ? true : null;

  // Getters for notifications
  List<AlertModel> get alerts => _alerts;
  int get unreadCount => _alerts.where((alert) => !alert.isRead).length;
  bool get hasUnreadAlerts => unreadCount > 0;

  // Voice activation methods
  void startListening() {
    _isListening = true;
    _alertTriggered = false;
    _timerSeconds = 15;
    notifyListeners();
    
    // Add notification
    addNotification(
      title: 'Voice Detection Active',
      message: 'Listening for emergency keywords...',
      type: 'system',
    );
  }

  void triggerAlert() {
    _alertTriggered = true;
    _isListening = false;
    notifyListeners();
    
    // Add SOS notification
    addNotification(
      title: 'SOS Alert Triggered!',
      message: 'Emergency alert sent to all guardians',
      type: 'sos',
    );
  }

  void cancelAlert() {
    _alertTriggered = false;
    _isListening = false;
    notifyListeners();
    
    // Add notification
    addNotification(
      title: 'Alert Cancelled',
      message: 'SOS alert has been cancelled',
      type: 'system',
    );
  }

  void confirmAlert() {
    _alertTriggered = false;
    _isListening = false;
    notifyListeners();
  }

  void stopListening() {
    _isListening = false;
    notifyListeners();
  }

  void decrementTimer() {
    if (_timerSeconds > 0) {
      _timerSeconds--;
      notifyListeners();
    }
  }

  void resetTimer() {
    _timerSeconds = 15;
    notifyListeners();
  }

  // Notification management methods
  void addNotification({
    required String title,
    required String message,
    required String type,
  }) {
    _alerts.insert(
      0,
      AlertModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        message: message,
        timestamp: DateTime.now(),
        type: type,
      ),
    );
    notifyListeners();
  }

  void markAsRead(String alertId) {
    final index = _alerts.indexWhere((alert) => alert.id == alertId);
    if (index != -1) {
      _alerts[index] = _alerts[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllAsRead() {
    _alerts = _alerts.map((alert) => alert.copyWith(isRead: true)).toList();
    notifyListeners();
  }

  void deleteNotification(String alertId) {
    _alerts.removeWhere((alert) => alert.id == alertId);
    notifyListeners();
  }

  void clearAllNotifications() {
    _alerts.clear();
    notifyListeners();
  }

  // Add guardian-related notification
  void addGuardianAlert({
    required String guardianName,
    required String message,
  }) {
    addNotification(
      title: 'Guardian Alert: $guardianName',
      message: message,
      type: 'guardian_alert',
    );
  }

  // Add voice detection notification
  void addVoiceDetectionAlert(String keyword) {
    addNotification(
      title: 'Emergency Keyword Detected',
      message: 'Voice command "$keyword" activated emergency protocol',
      type: 'voice',
    );
  }
}
