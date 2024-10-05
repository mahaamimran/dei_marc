import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';

class BulletWidget extends StatelessWidget {
  final String text;
  final Color bulletColor;
  final double fontSize;

  const BulletWidget({
    super.key,
    required this.text,
    required this.bulletColor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: fontSize * 0.5),
            child: Icon(
              Icons.double_arrow_rounded,
              size: fontSize,
              color: bulletColor,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText.rich(
              TextSpan(
                text: text,
                style: TextStyles.bullet(context).copyWith(fontSize: fontSize + 2, height: 1.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
