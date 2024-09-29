// widgets/content_widgets/bold_widget.dart
import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';

class BoldWidget extends StatelessWidget {
  final String text;
  final double fontSize;

  const BoldWidget({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        // Helpers.capitalizeTitle(text),
        text,
        style: TextStyles.bold(context).copyWith(fontSize: fontSize + 2),
      ),
    );
  }
}
