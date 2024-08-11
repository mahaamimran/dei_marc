import 'package:dei_marc/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController bookmarkController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFB52556),
                Color.fromARGB(255, 108, 160, 166),
              ],
            ),
          ),
        ),
        title: Text(
          'Bookmarks',
          style: TextStyles.appBarTitle
              .copyWith(color: const Color.fromARGB(255, 248, 246, 246)),
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 75.0, // Change this value to adjust AppBar height
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Consumer<SettingsProvider>(
                    builder: (context, settingsProvider, child) {
                      return TextField(
                        controller: bookmarkController,
                        decoration: const InputDecoration(
                          labelText: 'Add a new bookmark',
                        ),
                        style: TextStyle(
                          fontSize: settingsProvider.fontSize,
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final newBookmark = bookmarkController.text;
                    if (newBookmark.isNotEmpty) {
                      Provider.of<BookmarkProvider>(context, listen: false)
                          .addBookmark(newBookmark);
                      bookmarkController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<BookmarkProvider>(
              builder: (context, bookmarkProvider, child) {
                if (bookmarkProvider.bookmarks.isEmpty) {
                  return const Center(child: Text('No bookmarks yet.'));
                }
                return ListView.builder(
                  itemCount: bookmarkProvider.bookmarks.length,
                  itemBuilder: (context, index) {
                    final bookmark = bookmarkProvider.bookmarks[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0), // Padding between tiles
                      child: Consumer<SettingsProvider>(
                        builder: (context, settingsProvider, child) {
                          return ListTile(
                            tileColor: Colors.grey[
                                200], // Light grey background color for the tile
                            title: Text(
                              bookmark,
                              style: TextStyle(
                                fontSize: settingsProvider.fontSize,
                              ),
                            ),
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
          ),
        ],
      ),
    );
  }
}
