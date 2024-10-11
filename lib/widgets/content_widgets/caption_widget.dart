import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';

class CaptionWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final double lineHeight;
  const CaptionWidget({
    super.key,
    required this.text,
    required this.fontSize,
    this.lineHeight = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
      child: Center(
        child: SelectableText.rich(
          TextSpan(
            text: text,
            style: TextStyles.caption(context).copyWith(
              fontSize: fontSize - 2,
              color: Colors.grey,
              height: lineHeight,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
