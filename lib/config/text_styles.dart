import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';

class TextStyles {
  static TextStyle appBarTitle(BuildContext context) {
    double fontSize = Provider.of<SettingsProvider>(context).fontSize;
    return TextStyle(
      fontSize: fontSize + 10,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(255, 248, 247, 247),
    );
  }

  static TextStyle heading(BuildContext context) {
    double fontSize = Provider.of<SettingsProvider>(context).fontSize;
    return TextStyle(
      fontSize: fontSize + 8,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  static TextStyle title(BuildContext context) {
    double fontSize = Provider.of<SettingsProvider>(context).fontSize;
    return TextStyle(
      fontSize: fontSize + 2,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle caption(BuildContext context) {
    double fontSize = Provider.of<SettingsProvider>(context).fontSize;
    return TextStyle(
      fontSize: fontSize,
      color: Colors.grey[900],
    );
  }
}
