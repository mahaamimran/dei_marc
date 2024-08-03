import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  double _fontSize = 16.0;

  double get fontSize => _fontSize;

  SettingsProvider() {
    _loadSettings();
  }

  void setFontSize(double size) {
    _fontSize = size;
    _saveSettings();
    notifyListeners();
  }



  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    notifyListeners();
  }

  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', _fontSize);
  }
}
