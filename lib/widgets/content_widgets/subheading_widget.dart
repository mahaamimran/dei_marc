// widgets/content_widgets/subheading_widget.dart
import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';

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
      child: Text(
        Helpers.capitalizeTitle(subheading),
        style: TextStyles.subheading(context).copyWith(
          fontSize: fontSize + 2,
        ),
      ),
    );
  }
}
