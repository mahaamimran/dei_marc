import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/models/book.dart';
import 'package:dei_marc/config/asset_paths.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books => _books;

  Future<void> loadBooks() async {
    final String response = await rootBundle.loadString(AssetPaths.booksJson);
    final data = await json.decode(response);
    _books = (data['books'] as List).map((i) => Book.fromJson(i)).toList();
    notifyListeners();
  }
}
