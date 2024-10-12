import 'package:dei_marc/config/color_constants.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/widgets/platform_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'content_screen.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          scrolledUnderElevation: 0,
          leading: Consumer<BookmarkProvider>(
            builder: (context, bookmarkProvider, child) {
              return IconButton(
                icon:
                    const Icon(Icons.delete_outline_rounded, color: Colors.red),
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
                  icon: Icon(settingsProvider.isGridView
                      ? Icons.list_rounded
                      : Icons.grid_view_rounded),
                  onPressed: () {
                    settingsProvider
                        .setViewPreference(!settingsProvider.isGridView);
                  },
                );
              },
            ),
          ],
        ),
        body: Consumer2<BookmarkProvider, SettingsProvider>(
          builder: (context, bookmarkProvider, settingsProvider, child) {
            if (bookmarkProvider.bookmarks.isEmpty) {
              return const Center(child: Text('No bookmarks yet.'));
            }

            return settingsProvider.isGridView
                ? _buildGridView(bookmarkProvider, isTablet)
                : _buildListView(bookmarkProvider, isTablet);
          },
        ),
      ),
    );
  }

    Widget _buildGridView(BookmarkProvider bookmarkProvider, bool isTablet) {
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
      ),
      itemCount: bookmarkProvider.bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = bookmarkProvider.bookmarks[index];
        return _buildGridBookmarkCard(context, bookmark, isTablet);
      },
    );
  }

  Widget _buildGridBookmarkCard(
      BuildContext context, String bookmark, bool isTablet) {
    final parts = bookmark.split('-');
    final bookId = parts[0];
    final categoryId = int.parse(parts[1]);
    final categoryName = parts.length > 2 ? parts.sublist(2).join('-') : '';

    final int bookIdIndex = int.parse(bookId) - 1;
    final bookPrimaryColor = ColorConstants
        .booksPrimary[bookIdIndex % ColorConstants.booksSecondary.length];
    final bookSecondaryColor = ColorConstants
        .booksSecondary[bookIdIndex % ColorConstants.booksSecondary.length];

    return Material(
      color: bookSecondaryColor,
      borderRadius: BorderRadius.circular(16.0),
      elevation: 2.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${Helpers.getTitle(bookId)} $categoryId',
                style: TextStyles.appCaption.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? 18.0 : 12.0, // Adjust font size
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
                  fontSize: isTablet ? 18.0 : 12.0, // Adjust font size
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

  Widget _buildListView(BookmarkProvider bookmarkProvider, bool isTablet) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      itemCount: bookmarkProvider.bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = bookmarkProvider.bookmarks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: _buildListBookmarkCard(context, bookmark, isTablet),
        );
      },
    );
  }

  Widget _buildListBookmarkCard(
      BuildContext context, String bookmark, bool isTablet) {
    final parts = bookmark.split('-');
    final bookId = parts[0];
    final categoryId = int.parse(parts[1]);
    final categoryName = parts.length > 2 ? parts.sublist(2).join('-') : '';

    final int bookIdIndex = int.parse(bookId) - 1;
    final bookPrimaryColor = ColorConstants
        .booksPrimary[bookIdIndex % ColorConstants.booksSecondary.length];
    final bookSecondaryColor = ColorConstants
        .booksSecondary[bookIdIndex % ColorConstants.booksSecondary.length];

    return Material(
      color: bookSecondaryColor,
      borderRadius: BorderRadius.circular(16.0),
      elevation: 2.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
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
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          title: Text(
            '${Helpers.getTitle(bookId)} $categoryId',
            style: TextStyles.appCaption.copyWith(
              color: bookPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? 18.0 : 12.0, // Adjust font size
            ),
          ),
          subtitle: Text(
            categoryName,
            style: TextStyles.appCaption.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: isTablet ? 18.0 : 12.0, // Adjust font size
            ),
          ),
        ),
      ),
    );
  }

  void _showClearAllDialog(
      BuildContext context, BookmarkProvider bookmarkProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertDialog(
          title: "Clear all Bookmarks",
          content: "Are you sure you want to clear all bookmarks?",
          options: [
            PlatformAlertOption(
              label: "Cancel",
              onPressed: () {}, // Just dismiss the dialog
              isCancel: false, // This will be black
            ),
            PlatformAlertOption(
              label: "Clear",
              onPressed: () {
                bookmarkProvider.clearAllBookmarks();
              },
              isCancel: true, // This will be red
            ),
          ],
        );
      },
    );
  }
}
