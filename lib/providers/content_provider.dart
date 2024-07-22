
import 'dart:convert';

import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/models/subcategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContentProvider with ChangeNotifier {
  List<Subcategory> _subcategories = [];

  List<Subcategory> get subcategories => _subcategories;

  Future<void> loadSubcategories(String bookId, String categoryId) async {
    final String response = await rootBundle.loadString(AssetPaths.subcategoriesJson(bookId, categoryId));
    final data = await json.decode(response);
    _subcategories = (data['subcategories'] as List).map((i) => Subcategory(id: i['id'], name: i['name'], content: [])).toList();
    notifyListeners();
  }

  Future<void> loadContent(String bookId, String categoryId, String subcategoryId) async {
    final String response = await rootBundle.loadString(AssetPaths.contentJson(bookId, categoryId, subcategoryId));
    final data = await json.decode(response);
    int subcategoryIndex = _subcategories.indexWhere((subcategory) => subcategory.id == data['id']);
    if (subcategoryIndex != -1) {
      _subcategories[subcategoryIndex] = Subcategory.fromJson(data);
    }
    notifyListeners();
  }
}