import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/models/subcategory.dart';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/enums.dart'; 

class SubcategoryProvider with ChangeNotifier {
  String? description; 
  List<Subcategory> _subcategories = [];
  DataStatus _dataStatus = DataStatus.initial;

  List<Subcategory> get subcategories => _subcategories;
  DataStatus get dataStatus => _dataStatus;

  Future<void> loadSubcategories(String bookId, int categoryId) async {
    _dataStatus = DataStatus.loading;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString(AssetPaths.subcategoriesJson(bookId, categoryId));
      final data = await json.decode(response);

      description = data['description'];

      _subcategories = (data['subcategories'] as List).map((i) => Subcategory.fromJson(i)).toList();
      _dataStatus = DataStatus.loaded;
    } catch (e) {
      print("Error loading subcategories: $e");
      _dataStatus = DataStatus.failure;
    }

    notifyListeners();
  }
}
