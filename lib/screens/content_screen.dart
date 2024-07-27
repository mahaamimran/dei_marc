import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/subcategory_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/config/text_styles.dart';

class ContentScreen extends StatelessWidget {
  final String bookId;
  final int categoryId;

  const ContentScreen({super.key, required this.bookId, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SubcategoryProvider()..loadSubcategories(bookId, categoryId)),
        ChangeNotifierProvider(create: (context) => ContentProvider()..loadContent(bookId, categoryId, 1)),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text('Content', style: TextStyles.appBarTitle),
        ),
        body: Consumer<SubcategoryProvider>(
          builder: (context, subcategoryProvider, child) {
            if (subcategoryProvider.subcategories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: subcategoryProvider.subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = subcategoryProvider.subcategories[index];
                return FutureBuilder(
                  future: context.read<ContentProvider>().loadContent(bookId, categoryId, index + 1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final contents = context.read<ContentProvider>().contents['$categoryId-${index + 1}'] ?? [];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subcategory.name, style: TextStyles.heading),
                        if (subcategory.description != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(subcategory.description!, style: TextStyles.caption),
                          ),
                        ...contents.map((contentItem) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(contentItem.heading, style: TextStyles.title),
                              ...contentItem.content.map((quote) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text('“${quote.text}”', style: TextStyles.caption),
                                );
                              }),
                            ],
                          );
                        }),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}