import 'package:flutter/material.dart';

class BookmarkProvider with ChangeNotifier {
  final List<String> _bookmarks = [];

  List<String> get bookmarks => _bookmarks;

  void addBookmark(String bookmark) {
    _bookmarks.add(bookmark);
    notifyListeners();
  }

  void removeBookmark(String bookmark) {
    _bookmarks.remove(bookmark);
    notifyListeners();
  }
}
