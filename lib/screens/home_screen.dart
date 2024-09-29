import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/book_provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/screens/category_screen.dart';
import 'package:dei_marc/config/color_constants.dart';
import 'package:dei_marc/config/asset_paths.dart';

String toRoman(int number) {
  const romanNumerals = {1: 'I'};

  var result = '';
  var remaining = number;

  romanNumerals.forEach((value, roman) {
    while (remaining >= value) {
      result += roman;
      remaining -= value;
    }
  });

  return result;
}

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
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          scrolledUnderElevation: 0,
          title: Text(
            'Toolkits',
            style: TextStyles.appBarTitle.copyWith(color: Colors.black),
          ),
          actions: [
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) {
                return IconButton(
                  icon: Icon(
                    settingsProvider.isListView
                        ? Icons.grid_view_rounded
                        : Icons.list_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    settingsProvider
                        .setListViewPreference(!settingsProvider.isListView);
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Consumer<BookProvider>(
            builder: (context, bookProvider, child) {
              if (bookProvider.books.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Consumer<SettingsProvider>(
                      builder: (context, settingsProvider, child) {
                        return settingsProvider.isListView
                            ? _buildListView(bookProvider)
                            : _buildGridView(bookProvider);
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GENDER DEI TOOLKIT VOLUME ${toRoman(book.volume)}',
                        style:
                            TextStyles.appTitle.copyWith(color: primaryColor),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 125,
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(AssetPaths.bookCovers[
                                    index % AssetPaths.bookCovers.length]),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(children: [
                              Text(
                                book.title,
                                style: TextStyles.appCaption.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15.0),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                "By ${book.author}",
                                style: TextStyles.appCaption.copyWith(
                                    color: Colors.grey[800], fontSize: 12),
                              ),
                            ]),
                          ),
                        ],
                      ),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          AssetPaths
                              .bookCovers[index % AssetPaths.bookCovers.length],
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'GENDER DEI TOOLKIT: ${book.title} | Volume ${toRoman(book.volume)}',
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
