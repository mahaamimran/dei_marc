// widgets/content_widgets/quote_widget.dart
import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';

class QuoteWidget extends StatelessWidget {
  final String quote;
  final double fontSize;
  final Color appBarColor;

  const QuoteWidget({
    super.key,
    required this.quote,
    required this.fontSize,
    required this.appBarColor,
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
              child: RichText(
                text: TextSpan(
                  style: TextStyles.quote(context).copyWith(fontSize: fontSize),
                  children: Helpers.highlightCompanies(
                    quote,
                    TextStyles.quote(context).copyWith(fontSize: fontSize + 2),
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
