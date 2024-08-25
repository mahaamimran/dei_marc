import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  double _fontSize = 16.0;
  String _fontFamily = 'Raleway';
  bool _isGridView = true;

  double get fontSize => _fontSize;
  String get fontFamily => _fontFamily;
  bool get isGridView => _isGridView;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    _fontFamily = prefs.getString('fontFamily') ?? 'Raleway';
    _isGridView = prefs.getBool('isGridView') ?? true;
    notifyListeners();
  }

  void setFontSize(double size) async {
    _fontSize = size;
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', size);
    notifyListeners();
  }

  void setFontFamily(String fontFamily) async {
    _fontFamily = fontFamily;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fontFamily', fontFamily);
    notifyListeners();
  }

  void setViewPreference(bool isGridView) async {
    _isGridView = isGridView;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isGridView', isGridView);
    notifyListeners();
  }
}
