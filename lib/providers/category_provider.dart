import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/models/category.dart';
import 'package:dei_marc/config/asset_paths.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> loadCategories(String bookId) async {
    final String response = await rootBundle.loadString(AssetPaths.categoriesJson(bookId));
    final data = await json.decode(response);
    _categories = (data['categories'] as List).map((i) => Category.fromJson(i)).toList();
    notifyListeners();
  }
}
