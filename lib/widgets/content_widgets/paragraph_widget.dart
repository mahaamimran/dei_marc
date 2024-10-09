import 'package:flutter/material.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/config/text_styles.dart';

class ParagraphWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color highlightColor;
  final double lineHeight;

  const ParagraphWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.highlightColor,
    this.lineHeight = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SelectableText.rich(
        TextSpan(
          children: Helpers.highlightCompanies(
            text,
            TextStyles.content(context).copyWith(
              fontSize: fontSize + 2,
              height: lineHeight,
            ),
            highlightColor,
          ),
        ),
      ),
    );
  }
}
