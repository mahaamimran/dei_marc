import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/book_provider.dart';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'category_screen.dart'; // Ensure this import is correct

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Home', style: TextStyles.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<BookProvider>(
          builder: (context, bookProvider, child) {
            if (bookProvider.books.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Books', style: TextStyles.heading),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bookProvider.books.length,
                    itemBuilder: (context, index) {
                      final book = bookProvider.books[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryScreen(
                                bookFileName: book.bookId.toString(),
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.grey[200],
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(AssetPaths.placeholderImage),
                                const SizedBox(height: 8.0),
                                Text(book.title, style: TextStyles.title),
                                const SizedBox(height: 4.0),
                                Text('By ${book.author}', style: TextStyles.caption),
                                const SizedBox(height: 4.0),
                                Text('Volume ${book.volume}', style: TextStyles.caption),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
