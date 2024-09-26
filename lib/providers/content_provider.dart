import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/models/content_item.dart';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/enums.dart'; 

class ContentProvider extends ChangeNotifier {
  final Map<String, List<ContentItem>> _contents = {};
  DataStatus _dataStatus = DataStatus.initial;

  Map<String, List<ContentItem>> get contents => _contents;
  DataStatus get dataStatus => _dataStatus;

  Future<void> loadContent(String bookId, int categoryId, int subcategoryId) async {
    _dataStatus = DataStatus.loading;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString(
          AssetPaths.contentJson(bookId, categoryId, subcategoryId));
      final data = json.decode(response);

      // Handle the case where content is missing or not a list
      if (data['content'] == null || data['content'] is! List) {
        _contents['$categoryId-$subcategoryId'] = [
          ContentItem(
            category: data['category'],
            description: data['description'],
            heading: data['heading'], // Capture the heading if it exists
            content: [], // Empty content list
            image: _parseImagePath(data['image']), // Parse image path
          ),
        ];
      } else {
        _contents['$categoryId-$subcategoryId'] = [
          ContentItem(
            category: data['category'],
            description: data['description'],
            heading: data['heading'],
            content: [],
            image: _parseImagePath(data['image']), // Parse image path
          ),
          ...data['content'].map<ContentItem>((item) {
            return ContentItem.fromJson(item);
          }).toList(),
        ];
      }
      _dataStatus = DataStatus.loaded;
    } catch (e) {
      _dataStatus = DataStatus.failure;
    }

    notifyListeners();
  }

  String? _parseImagePath(List<dynamic>? imageData) {
    if (imageData != null && imageData.isNotEmpty) {
      final imageEntry = imageData.firstWhere(
          (element) => element['type'] == 'image',
          orElse: () => null);
      if (imageEntry != null) {
        return imageEntry['text'];
      }
    }
    return null;
  }
}
