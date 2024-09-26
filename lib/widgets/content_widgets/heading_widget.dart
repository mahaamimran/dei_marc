// widgets/heading_widget.dart
import 'package:flutter/material.dart';
import 'package:dei_marc/helpers/helpers.dart';
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
        Helpers.capitalizeTitle(heading),
        style: TextStyles.heading(context).copyWith(fontSize: fontSize + 4),
      ),
    );
  }
}
