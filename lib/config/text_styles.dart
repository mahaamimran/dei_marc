import 'package:flutter/material.dart';

class TextStyles {
  // AppBar Title Style
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 248, 247, 247),
  );

  // Heading Style
  static const TextStyle heading = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  // Subheading Style
  static const TextStyle subheading = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Title Style
  static const TextStyle title = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Caption Style
  static TextStyle caption = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 14,
    color: Colors.grey[900],
  );

  // Quote Text Style
  static const TextStyle quote = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 16,
    color: Colors.grey,
  );

  // Bullet Text Style
  static TextStyle bullet = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 16,
    color: Colors.grey[800],
  );

  // Bold Text Style
  static const TextStyle bold = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Standard Content Text Style
  static TextStyle content = TextStyle(
    fontFamily: 'Raleway',
    fontSize: 16,
    color: Colors.grey[800],
  );
}
