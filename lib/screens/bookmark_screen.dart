import 'package:dei_marc/config/color_constants.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'content_screen.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          scrolledUnderElevation: 0,
          leading: Consumer<BookmarkProvider>(
            builder: (context, bookmarkProvider, child) {
              return IconButton(
                icon: const Icon(Icons.delete_rounded, color: Colors.red),
                onPressed: () {
                  if (bookmarkProvider.bookmarks.isNotEmpty) {
                    _showClearAllDialog(context, bookmarkProvider);
                  }
                },
              );
            },
          ),
          title: Text(
            'Bookmarks',
            style: TextStyles.appBarTitle.copyWith(color: Colors.black),
          ),
          elevation: 0,
          actions: [
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) {
                return IconButton(
                  icon: Icon(settingsProvider.isGridView ? Icons.list : Icons.grid_view),
                  onPressed: () {
                    settingsProvider.setViewPreference(!settingsProvider.isGridView);
                  },
                );
              },
            ),
          ],
        ),
        body: Consumer2<BookmarkProvider, SettingsProvider>(
          builder: (context, bookmarkProvider, settingsProvider, child) {
            // If there are no bookmarks, display a message
            if (bookmarkProvider.bookmarks.isEmpty) {
              return const Center(child: Text('No bookmarks yet.'));
            }
      
            // Display the appropriate view (grid or list) based on user preference
            return settingsProvider.isGridView
                ? _buildGridView(bookmarkProvider)
                : _buildListView(bookmarkProvider);
          },
        ),
      ),
    );
  }

  // Build the grid view for bookmarks
  Widget _buildGridView(BookmarkProvider bookmarkProvider) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: bookmarkProvider.bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = bookmarkProvider.bookmarks[index];
        return _buildGridBookmarkCard(context, bookmark);
      },
    );
  }

  // Build the list view for bookmarks
  Widget _buildListView(BookmarkProvider bookmarkProvider) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: bookmarkProvider.bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = bookmarkProvider.bookmarks[index];
        return _buildListBookmarkCard(context, bookmark);
      },
    );
  }

  // Build the bookmark card for grid view
  Widget _buildGridBookmarkCard(BuildContext context, String bookmark) {
    final parts = bookmark.split('-');
    final bookId = parts[0];
    final categoryId = int.parse(parts[1]);
    final categoryName = parts.length > 2 ? parts.sublist(2).join('-') : '';

    final int bookIdIndex = int.parse(bookId) - 1;
    final bookPrimaryColor = ColorConstants.booksPrimary[bookIdIndex % ColorConstants.booksSecondary.length];
    final bookSecondaryColor = ColorConstants.booksSecondary[bookIdIndex % ColorConstants.booksSecondary.length];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContentScreen(
              bookId: bookId,
              categoryId: categoryId,
              appBarColor: bookPrimaryColor,
              secondaryColor: bookSecondaryColor,
              categoryName: categoryName,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: bookSecondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${Helpers.getTitle(bookId)} $categoryId',
                style: TextStyles.appCaption.copyWith(
                  fontWeight: FontWeight.bold,
                  color: bookPrimaryColor,
                ),
              ),
              const SizedBox(height: 4.0),
              Container(
                height: 2.0,
                width: 40.0,
                color: bookPrimaryColor,
              ),
              const SizedBox(height: 8.0),
              Text(
                categoryName,
                style: TextStyles.appCaption.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the bookmark card for list view
  Widget _buildListBookmarkCard(BuildContext context, String bookmark) {
    final parts = bookmark.split('-');
    final bookId = parts[0];
    final categoryId = int.parse(parts[1]);
    final categoryName = parts.length > 2 ? parts.sublist(2).join('-') : '';

    final int bookIdIndex = int.parse(bookId) - 1;
    final bookPrimaryColor = ColorConstants.booksPrimary[bookIdIndex % ColorConstants.booksSecondary.length];
    final bookSecondaryColor = ColorConstants.booksSecondary[bookIdIndex % ColorConstants.booksSecondary.length];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContentScreen(
              bookId: bookId,
              categoryId: categoryId,
              appBarColor: bookPrimaryColor,
              secondaryColor: bookSecondaryColor,
              categoryName: categoryName,
            ),
          ),
        );
      },
      child: Card(
        color: bookSecondaryColor,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text(
            '${Helpers.getTitle(bookId)} $categoryId',
            style: TextStyles.appCaption.copyWith(
              color: bookPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            categoryName,
            style: TextStyles.appCaption.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, BookmarkProvider bookmarkProvider) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Clear all Bookmarks"),
          content: const Text("Are you sure you want to clear all bookmarks?"),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              onPressed: () {
                bookmarkProvider.clearAllBookmarks();
                Navigator.of(context).pop();
              },
              isDestructiveAction: true,
              child: Text("Clear All", style: TextStyle(color: Colors.red
              )),
            ),
          ],
        );
      },
    );
  }
}
