import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider with ChangeNotifier {
  static const String _bookmarkKey = 'bookmarks';
  List<String> _bookmarks = [];

  List<String> get bookmarks => _bookmarks;

  BookmarkProvider() {
    _loadBookmarks();
  }

  void addBookmark(String bookmark) async {
    _bookmarks.add(bookmark);
    await _saveBookmarks();
    notifyListeners();
  }

  void removeBookmark(String bookmark) async {
    _bookmarks.remove(bookmark);
    await _saveBookmarks();
    notifyListeners();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_bookmarkKey, _bookmarks);
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarks = prefs.getStringList(_bookmarkKey) ?? [];
    notifyListeners();
  }

  bool isBookmarked(String bookmark) {
    return _bookmarks.contains(bookmark);
  }
}
