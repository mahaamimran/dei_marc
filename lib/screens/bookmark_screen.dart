import 'package:dei_marc/config/color_constants.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'content_screen.dart'; // Import the ContentScreen to navigate to it

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Bookmarks',
          style: TextStyles.appBarTitle,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, bookmarkProvider, child) {
          if (bookmarkProvider.bookmarks.isEmpty) {
            return const Center(child: Text('No bookmarks yet.'));
          }
          return ListView.builder(
            itemCount: bookmarkProvider.bookmarks.length,
            itemBuilder: (context, index) {
              final bookmark = bookmarkProvider.bookmarks[index];

              // Extract bookId, categoryId, and categoryName from bookmark
              final parts = bookmark.split('-');
              final bookId = parts[0];
              final categoryId = int.parse(parts[1]);
              final categoryName = parts.length > 2 ? parts[2] : '';

              // Determine the color associated with the bookId
              final int bookIdIndex = int.parse(bookId) - 1;
              final bookColor = ColorConstants.booksSecondary[bookIdIndex % ColorConstants.booksSecondary.length];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0), // Padding between tiles
                child: Consumer<SettingsProvider>(
                  builder: (context, settingsProvider, child) {
                    return ListTile(
                      tileColor: bookColor.withOpacity(0.2), // Light background color based on book color
                      title: Text(
                        Helpers.getTitle(bookId) + ' - ' + categoryName,
                        style: TextStyle(
                          fontSize: settingsProvider.fontSize,
                        ),
                      ),
                      onTap: () {
                        // Navigate to the ContentScreen when tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentScreen(
                              bookId: bookId,
                              categoryId: categoryId,
                              appBarColor: bookColor,
                              secondaryColor: Colors.grey, // Set the secondary color as needed
                              categoryName: categoryName,
                            ),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          bookmarkProvider.removeBookmark(bookmark);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
