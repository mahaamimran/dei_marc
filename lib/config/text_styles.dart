import 'package:dei_marc/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';

class TextStyles {
  // App-wide TextStyles (do not depend on BuildContext)
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: Constants.FONT_FAMILY_LEXEND,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle appTitle = TextStyle(
    fontFamily: Constants.FONT_FAMILY_LEXEND,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle appCaption = TextStyle(
    fontFamily: Constants.FONT_FAMILY_LEXEND,
    fontSize: 14,
    color: Colors.grey,
  );

  // Content-specific TextStyles (depend on BuildContext and user settings)
  static TextStyle heading(BuildContext context) {
    return TextStyle(
      fontFamily: Provider.of<SettingsProvider>(context).fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );
  }

  static TextStyle subheading(BuildContext context) {
    return TextStyle(
      fontFamily: Provider.of<SettingsProvider>(context).fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle title(BuildContext context) {
    return TextStyle(
      fontFamily: Provider.of<SettingsProvider>(context).fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle caption(BuildContext context) {
    return TextStyle(
      fontFamily: Provider.of<SettingsProvider>(context).fontFamily,
      fontSize: 16,
      color: Colors.grey[900],
    );
  }

  static TextStyle quote(BuildContext context) {
    return TextStyle(
      fontFamily: Provider.of<SettingsProvider>(context).fontFamily,
      fontSize: 16,
      color: Colors.grey[800],
      height: 1.25,
    );
  }

  static TextStyle bullet(BuildContext context) {
    return TextStyle(
      fontFamily: Provider.of<SettingsProvider>(context).fontFamily,
      fontSize: 16,
      color: Colors.grey[800],
      height: 1.25,
    );
  }

  static TextStyle bold(BuildContext context) {
    return TextStyle(
      fontFamily: Provider.of<SettingsProvider>(context).fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle content(BuildContext context) {
    return TextStyle(
      fontFamily: Provider.of<SettingsProvider>(context).fontFamily,
      fontSize: 16,
      color: Colors.grey[800],
      height: 1.25,
    );
  }
}
