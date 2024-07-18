// this is used to load the books from the json file and store it in a list of books
// this is our 'business logic' for the books
// we will use this provider to load the books in the home screen
// home screen will not directly load the books from the json file (layered architecture)
import 'dart:convert';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
