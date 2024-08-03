import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _images = [];

  List<Map<String, dynamic>> get images => _images;

  ImageProvider() {
    _loadImages();
  }

  Future<void> _loadImages() async {
    final String response = await rootBundle.loadString('assets/images/');
    final List<dynamic> data = jsonDecode(response);

    _images = List<Map<String, dynamic>>.from(data);
    notifyListeners();
  }

  String? getImagePathForCategory(int categoryId) {
    final image = _images.firstWhere(
      (img) => img['category_id'] == categoryId,
      orElse: () => {},
    );
    return image.isNotEmpty ? image['path'] : null;
  }
}
