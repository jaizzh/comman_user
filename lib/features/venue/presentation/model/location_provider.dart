import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  String _selectedLocation = "Madurai";

  String get selectedLocation => _selectedLocation;

  void updateLocation(String newLocation) {
    _selectedLocation = newLocation;
    notifyListeners(); // Refresh UI wherever it's used
  }
}
