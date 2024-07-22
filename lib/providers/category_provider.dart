import 'dart:convert';
import 'package:dei_marc/models/category.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> loadCategories(String bookFileName) async {
    final String response = await rootBundle.loadString('assets/data/categories/$bookFileName');
    final data = await json.decode(response);
    _categories = (data['categories'] as List).map((i) => Category.fromJson(i)).toList();
    notifyListeners();
  }
}
