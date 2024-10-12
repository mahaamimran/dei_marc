import 'package:dei_marc/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider with ChangeNotifier {
  static const String _bookmarkKey = Constants.BOOKMARKS_KEY;
  List<String> _bookmarks = [];

  List<String> get bookmarks => _bookmarks;

  BookmarkProvider() {
    _loadBookmarks();
  }

  void addBookmark(String bookmark) async {
    _bookmarks.add(bookmark);
    _sortBookmarks(); 
    await _saveBookmarks();
    notifyListeners();
  }

  void removeBookmark(String bookmark) async {
    _bookmarks.remove(bookmark);
    await _saveBookmarks();
    notifyListeners();
  }

  Future<void> clearAllBookmarks() async {
    _bookmarks.clear();
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
    _sortBookmarks(); // Sort bookmarks after loading
    notifyListeners();
  }

  bool isBookmarked(String bookmark) {
    return _bookmarks.contains(bookmark);
  }

  void _sortBookmarks() {
    _bookmarks.sort((a, b) {
      final bookIdA = int.parse(a.split('-')[0]);
      final bookIdB = int.parse(b.split('-')[0]);
      return bookIdA.compareTo(bookIdB); // Sort by bookId
    });
  }
}
