import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';

class SubcategoryNameWidget extends StatelessWidget {
  final String subcategoryName;
  final Color color;

  const SubcategoryNameWidget({
    super.key,
    required this.subcategoryName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<SettingsProvider>(context).fontSize;

    return SelectableText.rich(
      TextSpan(
        text: subcategoryName,
        style: TextStyles.subheading(context).copyWith(
          fontSize: fontSize + 8,
          color: color,
          height: 1.75,
        ),
      ),
    );
  }
}
