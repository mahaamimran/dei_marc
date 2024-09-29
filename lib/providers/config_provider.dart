import 'dart:convert';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfigProvider extends ChangeNotifier {
  static final ConfigProvider _instance = ConfigProvider._internal();

  factory ConfigProvider() {
    return _instance;
  }

  ConfigProvider._internal();

  Map<String, String> _imagePaths = {};
  Map<String, String> _pdfPaths = {};
  Map<String, String> _videoPaths = {};

  Future<void> loadConfig() async {
    final String response = await rootBundle.loadString(AssetPaths.configJson);
    final data = json.decode(response);

    // Check if 'image_paths' exists in the JSON
    if (data['image_paths'] != null && data['image_paths'] is Map) {
      _imagePaths = Map<String, String>.from(data['image_paths']);
    }

    // Check if 'pdf_paths' exists in the JSON
    if (data['pdf_paths'] != null && data['pdf_paths'] is Map) {
      _pdfPaths = Map<String, String>.from(data['pdf_paths']);
    }

    // Check if 'audio_paths' exists in the JSON
    if (data['video_paths'] != null && data['video_paths'] is Map) {
      _videoPaths = Map<String, String>.from(data['video_paths']);
    }

  }

  String? getImagePath(String? key) {
    return _imagePaths[key];
  }

  String? getPdfPath(String? key) {
    return _pdfPaths[key];
  }

  String? getVideoPath(String? key) {
    return _videoPaths[key];
  }
}
