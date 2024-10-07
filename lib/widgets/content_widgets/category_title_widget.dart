import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';

class CategoryTitleWidget extends StatelessWidget {
  final String categoryName;
  final Color barColor;
  final Color textColor;
  final double lineHeight;
  const CategoryTitleWidget({
    super.key,
    required this.categoryName,
    required this.barColor,
    required this.textColor,
    this.lineHeight = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<SettingsProvider>(context).fontSize;

    return Row(
      children: [
        Container(
          height: 50,
          width: 6,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 18.0),
        Expanded(
          child: SelectableText.rich(
            TextSpan(
              text: categoryName.toUpperCase(),
              style: TextStyles.heading(context).copyWith(
                fontSize: fontSize + 10,
                fontWeight: FontWeight.w700,
                color: textColor,
                height: lineHeight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
