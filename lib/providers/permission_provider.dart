import 'package:flutter/material.dart';
import '../models/permission_model.dart';
import '../services/permission_service.dart';

class PermissionProvider extends ChangeNotifier {
  final PermissionService _permissionService = PermissionService();
  
  PermissionModel? _permissions;
  bool _loading = false;

  PermissionModel? get permissions => _permissions;
  bool get loading => _loading;

  // Initialize with default permissions
  PermissionProvider() {
    _permissions = PermissionModel(
      id: 'default',
      locationPermission: false,
      microphonePermission: false,
      cameraPermission: false,
      lastUpdated: DateTime.now(),
    );
  }

  Future<void> initializePermissions() async {
    _loading = true;
    notifyListeners();

    try {
      final location = await _permissionService.checkLocationPermission();
      final microphone = await _permissionService.checkMicrophonePermission();
      final camera = await _permissionService.checkCameraPermission();

      _permissions = PermissionModel(
        id: 'default',
        locationPermission: location,
        microphonePermission: microphone,
        cameraPermission: camera,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      print('Error initializing permissions: $e');
    }

    _loading = false;
    notifyListeners();
  }

  Future<void> requestLocationPermission() async {
    if (_permissions == null) return;
    
    final granted = await _permissionService.requestLocationPermission();
    _permissions = _permissions!.copyWith(
      locationPermission: granted,
      lastUpdated: DateTime.now(),
    );
    notifyListeners();
  }

  Future<void> requestMicrophonePermission() async {
    if (_permissions == null) return;
    
    final granted = await _permissionService.requestMicrophonePermission();
    _permissions = _permissions!.copyWith(
      microphonePermission: granted,
      lastUpdated: DateTime.now(),
    );
    notifyListeners();
  }

  Future<void> requestCameraPermission() async {
    if (_permissions == null) return;
    
    final granted = await _permissionService.requestCameraPermission();
    _permissions = _permissions!.copyWith(
      cameraPermission: granted,
      lastUpdated: DateTime.now(),
    );
    notifyListeners();
  }

  // Toggle methods to directly change state (for UI testing)
  void toggleLocationPermission() {
    if (_permissions == null) return;
    _permissions = _permissions!.copyWith(
      locationPermission: !_permissions!.locationPermission,
      lastUpdated: DateTime.now(),
    );
    notifyListeners();
  }

  void toggleMicrophonePermission() {
    if (_permissions == null) return;
    _permissions = _permissions!.copyWith(
      microphonePermission: !_permissions!.microphonePermission,
      lastUpdated: DateTime.now(),
    );
    notifyListeners();
  }

  void toggleCameraPermission() {
    if (_permissions == null) return;
    _permissions = _permissions!.copyWith(
      cameraPermission: !_permissions!.cameraPermission,
      lastUpdated: DateTime.now(),
    );
    notifyListeners();
  }
}
