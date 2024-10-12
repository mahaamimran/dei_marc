import 'package:dei_marc/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/screens/pdf_screen.dart';

class PDFDownloadButton extends StatelessWidget {
  final String subcategoryName;
  final String text;
  final Color secondaryColor;
  final Color primaryColor;
  final String pdfUrl;
  final bool isCompletePDF;

  const PDFDownloadButton(
      {super.key,
      required this.subcategoryName,
      required this.text,
      required this.secondaryColor,
      required this.primaryColor,
      required this.pdfUrl,
      this.isCompletePDF = false});

  @override
  Widget build(BuildContext context) {
    if (pdfUrl.isEmpty || pdfUrl == "") return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PDFScreen(
                  appBarColor: primaryColor,
                  pdfUrl: pdfUrl,
                  title: text,
                  subcategoryName: subcategoryName,
                  isCompletePDF: isCompletePDF
                ),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_downward,
            size: 18,
            color: primaryColor,
          ),
          label: Text(
            text,
            style: TextStyles.caption(context).copyWith(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }
}
