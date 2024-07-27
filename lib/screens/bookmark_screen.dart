import 'package:dei_marc/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';
import 'package:dei_marc/config/color_constants.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController bookmarkController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title:  Text('Bookmarks',style: TextStyles.appBarTitle.copyWith(color: Colors.black),),
       // backgroundColor:
          //  Toolkit1Colors.magentaDark, // Assuming the default is for Toolkit 1
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
         // //  color: Toolkit1Colors
             //   .babyPinkBackground, // Background for adding bookmarks
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: bookmarkController,
                    decoration: const InputDecoration(
                      labelText: 'Add a new bookmark',
                    //  labelStyle:
                      //    TextStyle(color: Toolkit1Colors.categoryHeadingText),
                    ),
                  //  style:
                    //    const TextStyle(color: Toolkit1Colors.categoryNameText),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                 // color: Toolkit1Colors.magentaDark,
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
                    // Example condition to differentiate Toolkit 1 and Toolkit 2 bookmarks
                    final bool isToolkit1 = bookmark.startsWith('Book1');

                    return ListTile(
                      // tileColor: isToolkit1
                      //     ? Toolkit1Colors.babyPinkBackground
                      //     : Toolkit2Colors.babyPinkBackground,
                      title: Text(
                        bookmark,
                        style: TextStyle(
                          // color: isToolkit1
                          //     ? Toolkit1Colors.categoryNameText
                          //     : Toolkit2Colors.categoryNameText,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        // color: isToolkit1
                        //     ? Toolkit1Colors.magentaDark
                        //     : Toolkit2Colors.tealDark,
                        onPressed: () {
                          bookmarkProvider.removeBookmark(bookmark);
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
