// ignore_for_file: library_private_types_in_public_api

import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/providers/category_provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/screens/content_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/text_styles.dart';

class CategoryScreen extends StatefulWidget {
  final String bookFileName;
  final Color appBarColor;
  final Color secondaryColor;

  const CategoryScreen({
    super.key,
    required this.bookFileName,
    required this.appBarColor,
    required this.secondaryColor,
  });

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: ChangeNotifierProvider(
        create: (context) =>
            CategoryProvider()..loadCategories(widget.bookFileName),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: widget.appBarColor,
            title: Text(Helpers.getAppBarTitle(widget.bookFileName),
                style: TextStyles.appBarTitle),
            actions: [
              Consumer<SettingsProvider>(
                builder: (context, settingsProvider, child) {
                  return IconButton(
                    color: Colors.white,
                    icon: Icon(settingsProvider.isGridView
                        ? Icons.list_rounded
                        : Icons.grid_view_rounded),
                    onPressed: () {
                      settingsProvider
                          .setViewPreference(!settingsProvider.isGridView);
                    },
                  );
                },
              ),
            ],
          ),
          body: Consumer2<CategoryProvider, SettingsProvider>(
            builder: (context, categoryProvider, settingsProvider, child) {
              if (categoryProvider.categories.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return settingsProvider.isGridView
                  ? _buildGridView(context, categoryProvider, isTablet)
                  : _buildListView(context, categoryProvider, isTablet);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(BuildContext context, CategoryProvider categoryProvider, bool isTablet) {
  return Scrollbar(
    child: GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
      ),
      itemCount: categoryProvider.categories.length,
      itemBuilder: (context, index) {
        final category = categoryProvider.categories[index];
        final isLast = index == categoryProvider.categories.length - 1;
        final label = isLast
            ? 'ABOUT THE GENDER DEI TOOLKIT VOLUME ${Helpers.getVolume(widget.bookFileName)}'
            : '${Helpers.getTitle(widget.bookFileName)} ${index + 1}';

        return Material(
          color: widget.secondaryColor,
          borderRadius: BorderRadius.circular(16.0),
          elevation: 2.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContentScreen(
                    appBarColor: widget.appBarColor,
                    secondaryColor: widget.secondaryColor,
                    bookId: widget.bookFileName,
                    categoryId: index + 1,
                    categoryName: isLast ? label : category.name,
                    isLast: isLast,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyles.appCaption.copyWith(
                      fontWeight: FontWeight.bold,
                      color: widget.appBarColor,
                      fontSize: isTablet ? 18.0 : 14.0, // Adjust font size
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (!isLast) ...[
                    const SizedBox(height: 4.0),
                    Container(
                      height: 2.0,
                      width: 40.0,
                      color: widget.appBarColor,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      category.name,
                      style: TextStyles.appCaption.copyWith(
                        color: Colors.black,
                        fontSize: isTablet ? 18.0 : 14.0, // Adjust font size
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

  Widget _buildListView(
      BuildContext context, CategoryProvider categoryProvider, bool isTablet) {
    return Scrollbar(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        itemCount: categoryProvider.categories.length,
        itemBuilder: (context, index) {
          final category = categoryProvider.categories[index];
          final isLast = index == categoryProvider.categories.length - 1;
          final label = isLast
              ? 'ABOUT THE GENDER DEI TOOLKIT VOLUME ${Helpers.getVolume(widget.bookFileName)}'
              : '${Helpers.getTitle(widget.bookFileName)} ${index + 1}'; // Use dynamic label for last item

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              color: widget.secondaryColor,
              borderRadius: BorderRadius.circular(16.0),
              elevation: 2.0,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentScreen(
                        appBarColor: widget.appBarColor,
                        secondaryColor: widget.secondaryColor,
                        bookId: widget.bookFileName,
                        categoryId: index + 1,
                        categoryName: isLast ? label : category.name,
                        isLast: isLast,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 5.0),
                  title: Text(
                    label,
                    style: TextStyles.appCaption.copyWith(
                        color: widget.appBarColor,
                        fontWeight: FontWeight.bold,
                         fontSize: isTablet ? 18.0 : 14.0, // Adjust font size
                         ),
                    // Removed the TextAlign.center for left alignment
                  ),
                  subtitle: !isLast
                      ? Text(
                          category.name,
                          style: TextStyles.appCaption.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                             fontSize: isTablet ? 18.0 : 14.0, // Adjust font size
                          ),
                          // Removed the TextAlign.center for left alignment
                        )
                      : null, // Skip subtitle for the last item
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
