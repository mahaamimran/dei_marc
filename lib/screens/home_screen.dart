import 'package:dei_marc/config/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/book_provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/screens/category_screen.dart';
import 'package:dei_marc/config/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          scrolledUnderElevation: 0,
          title: Text(
            'Home',
            style: TextStyles.appBarTitle.copyWith(color: Colors.black),
          ),
          // actions: [
          //   IconButton(
          //     icon: Icon(
          //       _isListView ? Icons.view_module : Icons.view_list,
          //       color: Colors.black,
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         _isListView = !_isListView; // Toggle the view
          //       });
          //     },
          //   ),
          // ],
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
                    child: Text('Books',
                        style: TextStyles.appTitle.copyWith(fontSize: 24)),
                  ),
                  Expanded(
                    child: _buildGridView(bookProvider),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListView(BookProvider bookProvider) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: bookProvider.books.length,
        itemBuilder: (context, index) {
          final book = bookProvider.books[index];
          final primaryColor = ColorConstants
              .booksPrimary[index % ColorConstants.booksPrimary.length];
          final secondaryColor = ColorConstants
              .booksSecondary[index % ColorConstants.booksSecondary.length];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(16.0),
              elevation: 2.0,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
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
                child: ListTile(
                  leading: Container(
                    width: 80, // Fixed width
                    height: 100, // Fixed height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(ImageAssets
                            .bookCovers[index % ImageAssets.bookCovers.length]),
                        fit: BoxFit
                            .cover, // Ensures the image fits based on height
                      ),
                    ),
                  ),
                  title: Text(
                    book.title,
                    style: TextStyles.appTitle.copyWith(color: primaryColor),
                  ),
                  subtitle: Text(
                    'By ${book.author}',
                    style: TextStyles.appCaption.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridView(BookProvider bookProvider) {
    return Scrollbar(
      child: ListView.builder(
        itemCount: bookProvider.books.length,
        itemBuilder: (context, index) {
          final book = bookProvider.books[index];
          final primaryColor = ColorConstants
              .booksPrimary[index % ColorConstants.booksPrimary.length];
          final secondaryColor = ColorConstants
              .booksSecondary[index % ColorConstants.booksSecondary.length];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(16.0),
              elevation: 2.0,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(ImageAssets
                          .bookCovers[index % ImageAssets.bookCovers.length]),
                      const SizedBox(height: 8.0),
                      Text(
                        book.title,
                        style: TextStyles.appTitle.copyWith(
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'By ${book.author}',
                        style: TextStyles.appCaption.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
