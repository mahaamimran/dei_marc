import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/models/subcategory.dart';
import 'package:dei_marc/config/asset_paths.dart';

class SubcategoryProvider with ChangeNotifier {
  List<Subcategory> _subcategories = [];

  List<Subcategory> get subcategories => _subcategories;

  Future<void> loadSubcategories(String bookId, int categoryId) async {
    final String response = await rootBundle.loadString(AssetPaths.subcategoriesJson(bookId, categoryId));
    final data = await json.decode(response);
    _subcategories = (data['subcategories'] as List).map((i) => Subcategory.fromJson(i)).toList();
    notifyListeners();
  }
}
