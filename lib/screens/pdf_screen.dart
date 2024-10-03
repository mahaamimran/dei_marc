import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dei_marc/utils/connection_util.dart';

class PDFScreen extends StatefulWidget {
  final Color appBarColor;
  final String pdfUrl;
  final String title;
  final String subcategoryName;

  const PDFScreen({
    super.key,
    required this.appBarColor,
    required this.pdfUrl,
    required this.title,
    required this.subcategoryName,
  });

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late PdfViewerController _pdfViewerController;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _checkInternetConnection();
  }

  // Check the internet connection status using the utility function
  Future<void> _checkInternetConnection() async {
    bool isConnected = await ConnectionUtil().isConnected();
    setState(() {
      _isConnected = isConnected;
    });
  }

  // Handle launching the PDF URL in a browser if no internet connection
  Future<void> _launchPDFUrl() async {
    if (await canLaunch(widget.pdfUrl)) {
      await launch(widget.pdfUrl);
    } else {
      throw 'Could not launch ${widget.pdfUrl}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: widget.appBarColor,
        title: Text(
          Helpers.getPDFScreenAppBarTitle(widget.subcategoryName),
          style: TextStyles.appBarTitle.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_rounded, color: Colors.white),
            onPressed: () {
              // Share the PDF link
              Share.share(widget.pdfUrl);
            },
          ),
        ],
      ),
      body: _isConnected
          ? SfPdfViewer.network(
              widget.pdfUrl,
              controller: _pdfViewerController,
              canShowScrollStatus: true,
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 50, color: Colors.red),
                  const SizedBox(height: 20),
                  const Text(
                    'No Internet Connection',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: _launchPDFUrl,
                    child: const Text(
                      'Click here to view PDF in browser',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
