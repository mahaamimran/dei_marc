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
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
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
                            ? (isTablet
                                ? _buildTabletListView(bookProvider)
                                : _buildPhoneListView(bookProvider))
                            : (isTablet
                                ? _buildGridViewForTablet(bookProvider)
                                : _buildGridViewForPhone(bookProvider));
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

  /// List view for phones
  Widget _buildPhoneListView(BookProvider bookProvider) {
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
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'GENDER DEI TOOLKIT VOLUME ${toRoman(book.volume)}',
                          style:
                              TextStyles.appTitle.copyWith(color: primaryColor),
                        ),
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

  /// List view for tablets
  Widget _buildTabletListView(BookProvider bookProvider) {
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Larger image on the left for tablet
                      Container(
                        width: 150, // Larger size for tablet
                        height: 150, // Larger size for tablet
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(AssetPaths.bookCovers[
                                index % AssetPaths.bookCovers.length]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // Text on the right for tablet
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'GENDER DEI TOOLKIT VOLUME ${toRoman(book.volume)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.appTitle.copyWith(
                                color: primaryColor,
                               fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              book.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.appCaption.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize:18.0, // Larger font size for tablet
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'By ${book.author}',
                              style: TextStyles.appCaption.copyWith(
                                color: Colors.grey[800],
                                fontSize: 15.0, // Larger font size for tablet
                              ),
                            ),
                          ],
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

  Widget _buildGridViewForPhone(BookProvider bookProvider) {
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
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            AssetPaths.bookCovers[
                                index % AssetPaths.bookCovers.length],
                            fit: BoxFit.contain,
                          ),
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

  Widget _buildGridViewForTablet(BookProvider bookProvider) {
    final screenWidth = MediaQuery.of(context).size.width;
    print(screenWidth);
    // Adjust the number of grid columns based on the screen width
    final int crossAxisCount = screenWidth >= 1180
        ? 3
        : screenWidth >= 700
            ? 2
            : 1;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Adjust columns for responsiveness
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio:
            0.75, // Control the height dynamically (height/width ratio)
      ),
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
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          AssetPaths
                              .bookCovers[index % AssetPaths.bookCovers.length],
                          fit: BoxFit.contain,
                          width: double.infinity, // Full width image
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'GENDER DEI TOOLKIT: ${book.title} | Volume ${toRoman(book.volume)}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
    );
  }
}
