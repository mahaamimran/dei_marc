import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/models/content_item.dart';
import 'package:dei_marc/config/asset_paths.dart';

class ContentProvider with ChangeNotifier {
  Map<String, List<ContentItem>> _contents = {};

  Map<String, List<ContentItem>> get contents => _contents;

  Future<void> loadContent(String bookId, int categoryId, int subcategoryId) async {
    try {
      final String response = await rootBundle.loadString(
          AssetPaths.contentJson(bookId, categoryId, subcategoryId));
      final data = json.decode(response);
      if (data['content'] != null && data['content'] is List) {
        _contents['$categoryId-$subcategoryId'] = (data['content'] as List)
            .map((i) => ContentItem.fromJson(i))
            .toList();
      } else {
        _contents['$categoryId-$subcategoryId'] = [];
      }
    } catch (e) {
      print("Error loading content: $e");
      _contents['$categoryId-$subcategoryId'] = [];
    }
    notifyListeners();
  }
}
