import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';

class HeadingWidget extends StatelessWidget {
  final String heading;
  final double fontSize;
  final double lineHeight;
  const HeadingWidget({
    super.key,
    required this.heading,
    required this.fontSize,
    this.lineHeight = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SelectableText.rich(
        TextSpan(
          text: heading,
          style: TextStyles.heading(context).copyWith(fontSize: fontSize + 6, height: lineHeight),
        ),
      ),
    );
  }
}
