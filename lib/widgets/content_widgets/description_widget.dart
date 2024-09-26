// widgets/content_widgets/description_widget.dart
import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';

class DescriptionWidget extends StatelessWidget {
  final String description;
  final double fontSize;

  const DescriptionWidget({
    super.key,
    required this.description,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        description,
        style: TextStyles.content(context).copyWith(
          fontSize: fontSize + 2,
        ),
      ),
    );
  }
}
