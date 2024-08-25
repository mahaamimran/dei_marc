import 'package:dei_marc/config/color_constants.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'content_screen.dart'; 

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Bookmarks',
          style: TextStyles.appBarTitle.copyWith(color: Colors.black), // Correctly set text color in the TextStyle
        ),
        backgroundColor: Colors.white, // Set app bar background to white
        elevation: 0, // Remove the shadow
        actions: [
          Consumer<BookmarkProvider>(
            builder: (context, bookmarkProvider, child) {
              return IconButton(
                icon: Icon(Icons.delete_rounded, color: Colors.red), // Use rounded delete icon
                onPressed: () {
                  if (bookmarkProvider.bookmarks.isNotEmpty) {
                    _showClearAllDialog(context, bookmarkProvider);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, bookmarkProvider, child) {
          if (bookmarkProvider.bookmarks.isEmpty) {
            return const Center(child: Text('No bookmarks yet.'));
          }
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

              // Extract bookId, categoryId, and categoryName from bookmark
              final parts = bookmark.split('-');
              final bookId = parts[0];
              final categoryId = int.parse(parts[1]);
              final categoryName = parts.length > 2 ? parts.sublist(2).join('-') : '';

              // Determine the color associated with the bookId
              final int bookIdIndex = int.parse(bookId) - 1;
              final bookPrimaryColor = ColorConstants.booksPrimary[bookIdIndex % ColorConstants.booksSecondary.length];
              final bookSecondaryColor = ColorConstants.booksSecondary[bookIdIndex % ColorConstants.booksSecondary.length];

              return GestureDetector(
                onTap: () {
                  // Navigate to the ContentScreen when tapped
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
                  color: bookSecondaryColor, // Set card background to the secondary color
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${Helpers.getTitle(bookId)} ${categoryId}',
                          style: TextStyles.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: bookPrimaryColor, // Text color set to primary color
                            fontSize: 16, // Fixed font size
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                          height: 2.0,
                          width: 40.0,
                          color: bookPrimaryColor, // Line color set to primary color
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          categoryName,
                          style: TextStyles.caption.copyWith(
                            fontSize: 14, // Fixed font size
                            color: Colors.black, // Text color set to black
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showClearAllDialog(BuildContext context, BookmarkProvider bookmarkProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Clear All Bookmarks"),
          content: const Text("Are you sure you want to clear all bookmarks?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Clear All"),
              onPressed: () {
                bookmarkProvider.clearAllBookmarks(); // Call to clear all bookmarks
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
