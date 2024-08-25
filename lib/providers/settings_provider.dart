import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  double _fontSize = 16.0;
  String _fontFamily = 'Raleway'; 

  double get fontSize => _fontSize;
  String get fontFamily => _fontFamily;

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  void setFontFamily(String fontFamily) {
    _fontFamily = fontFamily;
    notifyListeners();
  }
}
