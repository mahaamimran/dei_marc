import 'package:flutter/material.dart';

// constants for the way text is displayed so we can use it like this:
// Text('Hello World', style: TextStyles.title)
class TextStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 248, 247, 247),
  );

  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.grey[900],
  );
}