import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';

class SubheadingWidget extends StatelessWidget {
  final String subheading;
  final double fontSize;

  const SubheadingWidget({
    super.key,
    required this.subheading,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SelectableText.rich(
        TextSpan(
          text: subheading,
          style: TextStyles.subheading(context).copyWith(
            fontSize: fontSize + 2,
            height: 1.75,
          ),
        ),
      ),
    );
  }
}
