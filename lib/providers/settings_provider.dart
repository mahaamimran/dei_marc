import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dei_marc/config/constants.dart';

class SettingsProvider with ChangeNotifier {
  double _fontSize = 15.0;
  String _fontFamily = Constants.FONT_FAMILY_LEXEND;
  bool _isGridView = true;
  bool _isListView = true; // home page view preference
  // bool _hasSeenOnboarding = false;

  // bool get hasSeenOnboarding => _hasSeenOnboarding;
  double get fontSize => _fontSize;
  String get fontFamily => _fontFamily;
  bool get isGridView => _isGridView;
  bool get isListView => _isListView;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble(Constants.FONT_SIZE_KEY) ?? 13.0;
    _fontFamily = prefs.getString(Constants.FONT_FAMILY_KEY) ??
        Constants.FONT_FAMILY_LEXEND;
    _isGridView = prefs.getBool(Constants.IS_GRID_VIEW_KEY) ?? true;
    _isListView = prefs.getBool(Constants.IS_LIST_VIEW_KEY) ?? true;
    // _hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    false;
    notifyListeners();
  }

  // Future<void> setHasSeenOnboarding(bool value) async {
  //   _hasSeenOnboarding = value;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('hasSeenOnboarding', value);
  //   notifyListeners();
  // }

  void setFontSize(double size) async {
    _fontSize = size;
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble(Constants.FONT_SIZE_KEY, size);
    notifyListeners();
  }

  void setFontFamily(String fontFamily) async {
    _fontFamily = fontFamily;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.FONT_FAMILY_KEY, fontFamily);
    notifyListeners();
  }

  void setViewPreference(bool isGridView) async {
    _isGridView = isGridView;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.IS_GRID_VIEW_KEY, isGridView);
    notifyListeners();
  }

  void setListViewPreference(bool isListView) async {
    _isListView = isListView;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.IS_LIST_VIEW_KEY, isListView);
    notifyListeners();
  }
}
