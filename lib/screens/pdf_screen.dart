import 'package:dei_marc/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';

class PDFScreen extends StatefulWidget {
  final Color appBarColor;
  final String pdfUrl;

  const PDFScreen({
    super.key,
    required this.appBarColor,
    required this.pdfUrl,
  });

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: widget.appBarColor,
        title: Text(
          'PDF Viewer',
          style: TextStyles.appBarTitle.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white), 
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              // Share the PDF link
              Share.share(widget.pdfUrl);
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_in, color: Colors.white),
            onPressed: () {
              _pdfViewerController.zoomLevel += 0.25;
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out, color: Colors.white),
            onPressed: () {
              _pdfViewerController.zoomLevel -= 0.25;
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.pdfUrl,
        controller: _pdfViewerController,
        canShowScrollStatus: true,
      ),
    );
  }
}
