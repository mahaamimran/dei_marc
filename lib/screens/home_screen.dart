import 'package:dei_marc/config/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/book_provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/screens/category_screen.dart';
import 'package:dei_marc/config/color_constants.dart';
import 'package:dei_marc/providers/settings_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 245, 245, 245),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFB52556),
                Color.fromARGB(255, 108, 161, 166),
              ],
            ),
          ),
        ),
        title: Text(
          'Home',
          style: TextStyles.appBarTitle(context).copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        // Increase AppBar height
        toolbarHeight: 80.0, // Change this value to adjust AppBar height
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Consumer<BookProvider>(
          builder: (context, bookProvider, child) {
            if (bookProvider.books.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Books',
                    style: TextStyles.heading(context),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: bookProvider.books.length,
                    itemBuilder: (context, index) {
                      final book = bookProvider.books[index];
                      final primaryColor = ColorConstants.booksPrimary[
                          index % ColorConstants.booksPrimary.length];
                      final secondaryColor = ColorConstants.booksSecondary[
                          index % ColorConstants.booksSecondary.length];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryScreen(
                                bookFileName: book.bookId.toString(),
                                appBarColor: primaryColor,
                                secondaryColor: secondaryColor,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color:
                              secondaryColor, // Set the background color to booksSecondary
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(ImageAssets.bookCovers[
                                    index % ImageAssets.bookCovers.length]),
                                const SizedBox(height: 8.0),
                                Text(
                                  book.title,
                                  style: TextStyles.title(context).copyWith(
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'By ${book.author}',
                                  style: TextStyles.caption(context),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Volume ${book.volume}',
                                  style: TextStyles.caption(context),
                                ),
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
