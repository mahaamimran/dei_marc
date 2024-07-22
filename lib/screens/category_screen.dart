import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/category_provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'content_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String bookFileName;

  const CategoryScreen({super.key, required this.bookFileName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryProvider()..loadCategories(bookFileName),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text('Categories', style: TextStyles.appBarTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              if (categoryProvider.categories.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Browse by category', style: TextStyles.heading),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: categoryProvider.categories.length,
                      itemBuilder: (context, index) {
                        final category = categoryProvider.categories[index];
                        return Card(
                          color: Colors.grey[200],
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(category.name, style: TextStyles.title),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContentScreen(
                                    bookId: bookFileName,
                                    categoryId: index + 1, // Pass the index of the category
                                  ),
                                ),
                              );
                            },
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
