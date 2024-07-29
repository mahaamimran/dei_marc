import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/subcategory_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';

class ContentScreen extends StatelessWidget {
  final String bookId;
  final int categoryId;
  final Color appBarColor; // Add a parameter for the AppBar color
  final Color secondaryColor; // Add a parameter for the secondary color

  const ContentScreen({
    super.key,
    required this.bookId,
    required this.categoryId,
    required this.appBarColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                SubcategoryProvider()..loadSubcategories(bookId, categoryId)),
        ChangeNotifierProvider(
            create: (context) =>
                ContentProvider()..loadContent(bookId, categoryId, 1)),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor, // Use the passed color for the AppBar
          foregroundColor: Colors.white,
          title: Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
              return Text(
                'Toolkit $categoryId',
                style: TextStyles.appBarTitle(context).copyWith(
                  fontSize: settingsProvider.fontSize + 2, // Adjust font size
                ),
              );
            },
          ),
          toolbarHeight: 75.0, // Change this value to adjust AppBar height
        ),
        body: Consumer<SubcategoryProvider>(
          builder: (context, subcategoryProvider, child) {
            if (subcategoryProvider.subcategories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: subcategoryProvider.subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = subcategoryProvider.subcategories[index];
                return FutureBuilder(
                  future: context
                      .read<ContentProvider>()
                      .loadContent(bookId, categoryId, index + 1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final contents = context
                            .read<ContentProvider>()
                            .contents['$categoryId-${index + 1}'] ??
                        [];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<SettingsProvider>(
                                builder: (context, settingsProvider, child) {
                                  return Text(
                                    subcategory.name.toUpperCase(),
                                    style: TextStyles.heading(context).copyWith(
                                      color: appBarColor,
                                      fontSize: settingsProvider.fontSize + 2,
                                    ),
                                  );
                                },
                              ),
                              if (subcategory.description != null)
                                Consumer<SettingsProvider>(
                                  builder: (context, settingsProvider, child) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        subcategory.description!,
                                        style: TextStyles.caption(context)
                                            .copyWith(
                                          color: Colors.black,
                                          fontSize: settingsProvider.fontSize,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ...contents.map((contentItem) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Consumer<SettingsProvider>(
                                        builder:
                                            (context, settingsProvider, child) {
                                          return Text(
                                            contentItem.heading,
                                            style: TextStyles.title(context)
                                                .copyWith(
                                              fontSize:
                                                  settingsProvider.fontSize + 2,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 8.0),
                                      ...contentItem.content.map((quote) {
                                        return Consumer<SettingsProvider>(
                                          builder: (context, settingsProvider,
                                              child) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Text(
                                                '“${quote.text}”',
                                                style:
                                                    TextStyles.caption(context)
                                                        .copyWith(
                                                  color: Colors.grey[800],
                                                  fontSize:
                                                      settingsProvider.fontSize,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
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
