import 'dart:io';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/widgets/platform_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
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
  String? _pdfFilePath;
  bool _isDownloading = false;
  double _downloadProgress = 0;
  http.Client? _httpClient;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    _httpClient = http.Client(); // Initialize the HTTP client
    _checkInternetConnection();
    _checkAndDownloadPDF(); // Start checking for cached file or downloading when the screen opens
  }

  @override
  void dispose() {
    _httpClient?.close(); // Close the HTTP client
    super.dispose();
  }

  // Check the internet connection status using the utility function
  Future<void> _checkInternetConnection() async {
    bool isConnected = await ConnectionUtil().isConnected();
    if (mounted) {
      setState(() {
        _isConnected = isConnected;
      });
    }
  }

  // Check if the file is cached, if not download it
  Future<void> _checkAndDownloadPDF() async {
    // Get a path in the application document directory (permanent directory)
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/${widget.title}.pdf';

    final file = File(filePath);

    // If the file already exists, use it
    if (await file.exists()) {
      setState(() {
        _pdfFilePath = filePath;
        _isDownloading = false;
      });
    } else {
      // File doesn't exist, download it
      _downloadPDF(filePath);
    }
  }

  // Download the PDF and save it to the device's local storage with progress tracking
  Future<void> _downloadPDF(String filePath) async {
    if (!mounted) return; // Ensure the widget is still in the tree

    setState(() {
      _isDownloading = true;
      _downloadProgress = 0; // Reset progress
    });

    try {
      final request =
          _httpClient!.send(http.Request('GET', Uri.parse(widget.pdfUrl)));
      final file = File(filePath);

      final response = await request;
      final contentLength = response.contentLength;

      List<int> bytes = [];
      response.stream.listen(
        (newBytes) {
          bytes.addAll(newBytes);
          if (mounted) {
            setState(() {
              _downloadProgress = bytes.length / contentLength!;
            });
          }
        },
        onDone: () async {
          await file.writeAsBytes(bytes);
          if (mounted) {
            setState(() {
              _pdfFilePath = filePath;
              _isDownloading = false;
            });
          }
        },
        onError: (e) {
          print("Error downloading file: $e");
          if (mounted) {
            setState(() {
              _isDownloading = false;
            });
          }
        },
        cancelOnError: true,
      );
    } catch (e) {
      print('Error downloading PDF: $e');
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  // Platform-specific share dialog
  Future<void> _showShareOptions(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return PlatformAlertDialog(
          title: "Share PDF or Link",
          content: "Would you like to share the PDF file or just the link? Sharing the link is faster.",
          options: [
            PlatformAlertOption(
              label: "Cancel",
              onPressed: () {},  // Just dismiss the dialog
              isCancel: true,  // Red for Cancel
            ),
            PlatformAlertOption(
              label: "PDF",
              onPressed: _sharePDF,  // Share the PDF file
              useDefaultColor: true,  // Use platform default color
            ),
            PlatformAlertOption(
              label: "Link",
              onPressed: _shareLink,  // Share the link
              useDefaultColor: true,  // Use platform default color
            ),
          ],
        );
      },
    );
  }

  // Share the downloaded PDF file
  Future<void> _sharePDF() async {
    if (_pdfFilePath == null) {
      await _checkAndDownloadPDF();
    }
    if (_pdfFilePath != null) {
      Share.shareXFiles([XFile(_pdfFilePath!)], subject: widget.title);
    }
  }

  // Share the link directly
  void _shareLink() {
    Share.share(widget.pdfUrl, subject: widget.title);
  }

  // Handle launching the PDF URL in a browser if no internet connection
  void _launchPDFUrl() async {
    try {
      Uri parsedUrl = Uri.parse(widget.pdfUrl);
      if (!await launchUrl(parsedUrl, mode: LaunchMode.platformDefault)) {
        throw Exception('Could not launch $widget.pdfUrl');
      }
    } catch (e) {
      print('Error launching URL: $e');
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
            onPressed: () =>
                _showShareOptions(context), // Show the share options dialog
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_pdfFilePath != null)
            SfPdfViewer.file(
              File(_pdfFilePath!), // Open from local file
              controller: _pdfViewerController,
              canShowScrollStatus: true,
            )
          else if (_isConnected && _isDownloading)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LinearProgressIndicator(
                    value: _downloadProgress,
                    backgroundColor: Colors.grey.shade300,
                    color: widget.appBarColor,
                  ),
                ),
                Text(
                  "${(_downloadProgress * 100).toStringAsFixed(0)}% downloaded",
                  style: TextStyles.appCaption.copyWith(fontSize: 14),
                ),
              ],
            )
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 50, color: Colors.red),
                  const SizedBox(height: 20),
                  const Text(
                    'No Internet Connection',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
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
        ],
      ),
    );
  }
}
