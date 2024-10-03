// widgets/heading_widget.dart
import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';

class HeadingWidget extends StatelessWidget {
  final String heading;
  final double fontSize;

  const HeadingWidget({
    super.key,
    required this.heading,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        heading,
        style: TextStyles.heading(context).copyWith(fontSize: fontSize + 6,height: 1.25),
      ),
    );
  }
}
