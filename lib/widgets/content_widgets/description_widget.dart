import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';

class DescriptionWidget extends StatelessWidget {
  final String description;
  final double fontSize;
  final double lineHeight; 

  const DescriptionWidget({
    super.key,
    required this.description,
    required this.fontSize,
    this.lineHeight = 1.5, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SelectableText.rich(
        TextSpan(
          text: description,
          style: TextStyles.content(context).copyWith(
            fontSize: fontSize + 2,
            height: lineHeight, 
          ),
        ),
      ),
    );
  }
}
