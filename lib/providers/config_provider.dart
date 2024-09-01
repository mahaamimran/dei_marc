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

  Future<void> loadConfig() async {
    final String response = await rootBundle.loadString(AssetPaths.configJson);
    final data = json.decode(response);

    _imagePaths = Map<String, String>.from(data['image_paths']);
  }

  String? getImagePath(String key) {
    return _imagePaths[key];
  }
}
