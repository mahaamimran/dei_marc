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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: ChangeNotifierProvider(
        create: (context) =>
            CategoryProvider()..loadCategories(widget.bookFileName),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: widget.appBarColor,
            title: Text("Categories", style: TextStyles.appBarTitle(context)),
            actions: [
              Consumer<SettingsProvider>(
                builder: (context, settingsProvider, child) {
                  return IconButton(
                    color: Colors.white,
                    icon: Icon(settingsProvider.isGridView
                        ? Icons.list
                        : Icons.grid_view),
                    onPressed: () {
                      settingsProvider
                          .setViewPreference(!settingsProvider.isGridView);
                    },
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer2<CategoryProvider, SettingsProvider>(
              builder: (context, categoryProvider, settingsProvider, child) {
                if (categoryProvider.categories.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12.0),
                    Expanded(
                      child: settingsProvider.isGridView
                          ? _buildGridView(context, categoryProvider)
                          : _buildListView(context, categoryProvider),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(
      BuildContext context, CategoryProvider categoryProvider) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: categoryProvider.categories.length,
      itemBuilder: (context, index) {
        final category = categoryProvider.categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContentScreen(
                    appBarColor: widget.appBarColor,
                    secondaryColor: widget.secondaryColor,
                    bookId: widget.bookFileName,
                    categoryId: index + 1,
                    categoryName: category.name),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            color: widget.secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${Helpers.getTitle(widget.bookFileName)} ${index + 1}',
                    style: TextStyles.caption(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: widget.appBarColor,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    height: 2.0,
                    width: 40.0,
                    color: widget.appBarColor,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    category.name,
                    style: TextStyles.caption(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView(
      BuildContext context, CategoryProvider categoryProvider) {
    return ListView.builder(
      itemCount: categoryProvider.categories.length,
      itemBuilder: (context, index) {
        final category = categoryProvider.categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContentScreen(
                    appBarColor: widget.appBarColor,
                    secondaryColor: widget.secondaryColor,
                    bookId: widget.bookFileName,
                    categoryId: index + 1,
                    categoryName: category.name),
              ),
            );
          },
          child: Card(
            color: widget.secondaryColor,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                '${Helpers.getTitle(widget.bookFileName)} ${index + 1}',
                style: TextStyles.caption(context).copyWith(
                  color: widget.appBarColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                category.name,
                style: TextStyles.caption(context).copyWith(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        );
      },
    );
  }
}
