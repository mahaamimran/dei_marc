import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/widgets/content_widgets/subcategory_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/screens/pdf_screen.dart';

class DeckOfSlidesWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color secondaryColor;
  final Color primaryColor;
  final String pdfUrl;

  const DeckOfSlidesWidget({
    super.key,
    required this.text,
    required this.fontSize,
    required this.secondaryColor,
    required this.primaryColor,
    required this.pdfUrl, // Accept the PDF URL
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SubcategoryNameWidget(
        //   subcategoryName: text,
        //   color: primaryColor,
        // ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () {
            // Navigate to PDFScreen with the PDF URL
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFScreen(
                  appBarColor: primaryColor,
                  pdfUrl: pdfUrl, // Pass the PDF URL to the screen
                ),
              ),
            );
          },
          icon: const Icon(Icons.download, color: Colors.white),
          label: Text('Download Deck of Slides',
              style: TextStyles.caption(context).copyWith(color: primaryColor)),
          style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
        ),
      ],
    );
  }
}
