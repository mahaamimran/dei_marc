import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/config/color_constants.dart';

class ContentScreen extends StatelessWidget {
  final String bookId;
  final String categoryId;

  const ContentScreen(
      {super.key, required this.bookId, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ContentProvider()..loadSubcategories(bookId, categoryId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: BasicColors.background,
          foregroundColor: BasicColors.appBarForeground,
          title: const Text('Content', style: TextStyles.appBarTitle),
        ),
        body: Consumer<ContentProvider>(
          builder: (context, contentProvider, child) {
            if (contentProvider.subcategories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: contentProvider.subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = contentProvider.subcategories[index];
                return FutureBuilder(
                  future: contentProvider.loadContent(
                      bookId, categoryId, subcategory.id.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(subcategory.name, style: TextStyles.heading),
                        ...subcategory.content.map((contentItem) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(contentItem.name, style: TextStyles.title),
                              ...contentItem.content.map((quote) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text('“${quote.text}”',
                                      style: TextStyles.caption),
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
