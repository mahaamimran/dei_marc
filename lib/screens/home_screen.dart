import 'package:dei_marc/config/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/book_provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/screens/category_screen.dart';
import 'package:dei_marc/config/color_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          // to avoid color change on scroll
          scrolledUnderElevation: 0,
          title: Text(
            'Home',
            style: TextStyles.appBarTitle(context).copyWith(color: Colors.black),
          ),
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
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Books', style: TextStyles.heading(context)),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: bookProvider.books.length,
                      itemBuilder: (context, index) {
                        // code for each book 'index' amount of times
                        final book = bookProvider.books[index];
                        // % to avoid index out of bounds
                        final primaryColor = ColorConstants.booksPrimary[
                            index % ColorConstants.booksPrimary.length];
                        final secondaryColor = ColorConstants.booksSecondary[
                            index % ColorConstants.booksSecondary.length];
                        return GestureDetector(
                          onTap: () {
                            print(book.bookId.toString());
                            print('object');
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
                            color: Colors.white,
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
                                    style: TextStyles.title
                                        (context).copyWith(color: primaryColor),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    'By ${book.author}',
                                    style: TextStyles.caption(context),
                                  ),
                                  const SizedBox(height: 4.0),
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
      ),
    );
  }
}
