import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/subcategory_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/providers/image_provider.dart' as my_image_provider;

class ContentScreen extends StatefulWidget {
  final String bookId;
  final int categoryId;
  final Color appBarColor;
  final Color secondaryColor;

  const ContentScreen({
    super.key,
    required this.bookId,
    required this.categoryId,
    required this.appBarColor,
    required this.secondaryColor,
  });

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  String? _selectedSubcategoryName;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => SubcategoryProvider()
              ..loadSubcategories(widget.bookId, widget.categoryId)),
        ChangeNotifierProvider(
            create: (context) => ContentProvider()
              ..loadContent(widget.bookId, widget.categoryId, 1)),
        ChangeNotifierProvider(
            create: (_) =>
                my_image_provider.ImageProvider()), // Use the alias here
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.appBarColor,
          foregroundColor: Colors.white,
          title: Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
              return Text(
                'Category ${widget.categoryId}',
                style: TextStyles.appBarTitle(context).copyWith(
                  fontSize: settingsProvider.fontSize + 2,
                ),
              );
            },
          ),
          toolbarHeight: 75.0,
        ),
        body: Consumer<SubcategoryProvider>(
          builder: (context, subcategoryProvider, child) {
            if (subcategoryProvider.subcategories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final imagePath = context
                .read<my_image_provider.ImageProvider>()
                .getImagePathForCategory(widget.categoryId);

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                if (imagePath != null) Image.asset(imagePath),
                ...subcategoryProvider.subcategories.map((subcategory) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subcategory.name.toUpperCase(),
                          style: TextStyles.heading(context).copyWith(
                            color: widget.appBarColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                          value: _selectedSubcategoryName == subcategory.name
                              ? subcategory.name
                              : null,
                          hint: const Text('Select Subcategory'),
                          items: subcategoryProvider.subcategories.map((sub) {
                            return DropdownMenuItem<String>(
                              value: sub.name,
                              child: Text(sub.name),
                            );
                          }).toList(),
                          onChanged: (selectedName) {
                            setState(() {
                              _selectedSubcategoryName = selectedName;
                            });
                            context.read<ContentProvider>().loadContent(
                                  widget.bookId,
                                  widget.categoryId,
                                  subcategoryProvider.subcategories.indexWhere(
                                          (sub) => sub.name == selectedName) +
                                      1,
                                );
                          },
                        ),
                        Consumer<ContentProvider>(
                          builder: (context, contentProvider, child) {
                            final contents = contentProvider.contents[
                                    '${widget.categoryId}-${subcategoryProvider.subcategories.indexWhere((sub) => sub.name == _selectedSubcategoryName) + 1}'] ??
                                [];

                            if (_selectedSubcategoryName == subcategory.name) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: contents.map((contentItem) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          contentItem.heading,
                                          style: TextStyles.title(context)
                                              .copyWith(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        ...contentItem.content.map((quote) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: Text(
                                              '“${quote.text}”',
                                              style: TextStyles.caption(context)
                                                  .copyWith(
                                                color: Colors.grey[800],
                                                fontSize: 14,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
