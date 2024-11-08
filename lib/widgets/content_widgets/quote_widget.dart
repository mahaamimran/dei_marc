import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';

class QuoteWidget extends StatelessWidget {
  final String quote;
  final double fontSize;
  final Color appBarColor;
  final double lineHeight;

  const QuoteWidget({
    super.key,
    required this.quote,
    required this.fontSize,
    required this.appBarColor,
    this.lineHeight = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.grey.shade400,
              width: 4,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.format_quote_rounded,
              size: 20,
              color: Colors.grey,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SelectableText.rich(
                TextSpan(
                  children: Helpers.highlightCompanies(
                    quote,
                    TextStyles.quote(context).copyWith(fontSize: fontSize + 2, height: lineHeight),
                    appBarColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
