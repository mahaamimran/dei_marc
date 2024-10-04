import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';

class CaptionWidget extends StatelessWidget {
  final String text;
  final double fontSize;

  const CaptionWidget({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Center(
        child: SelectableText.rich(
          TextSpan(
            text: text,
            style: TextStyles.caption(context).copyWith(
              fontSize: fontSize - 2,
              color: Colors.grey,
              height: 1.75
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
