import 'package:dei_marc/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/screens/pdf_screen.dart';

class PDFDownloadButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color secondaryColor;
  final Color primaryColor;
  final String pdfUrl;

  const PDFDownloadButton({
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
          label: Text(text,
              style: TextStyles.caption(context).copyWith(color: primaryColor)),
          style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
        ),
      ],
    );
  }
}
