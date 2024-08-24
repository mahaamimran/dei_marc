import 'package:dei_marc/models/content_item.dart';
import 'package:dei_marc/models/quote.dart';
import 'package:dei_marc/providers/config_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/providers/subcategory_provider.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentListWidget extends StatelessWidget {
  final int categoryId;
  final Color appBarColor;
  final Color secondaryColor;
  final String categoryName;
  final ScrollController scrollController;
  final Map<String, GlobalKey> keyMap;

  const ContentListWidget({
    Key? key,
    required this.categoryId,
    required this.appBarColor,
    required this.secondaryColor,
    required this.categoryName,
    required this.scrollController,
    required this.keyMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SubcategoryProvider>(
      builder: (context, subcategoryProvider, child) {
        if (subcategoryProvider.subcategories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        keyMap.clear();

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(16.0),
          itemCount: subcategoryProvider.subcategories.length,
          itemBuilder: (context, index) {
            final subcategory = subcategoryProvider.subcategories[index];
            final key = GlobalKey();
            keyMap['$categoryId-$index'] = key;

            return Padding(
              key: key,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0) ...[
                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 6,
                          decoration: BoxDecoration(
                            color: appBarColor,
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                        ),
                        const SizedBox(width: 18.0),
                        Expanded(
                          child: Text(
                            Helpers.capitalizeTitle(categoryName).toUpperCase(),
                            style: TextStyle(
                              fontSize: Provider.of<SettingsProvider>(context).fontSize * 1.5, // Heading scale
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Image before subcategory title
                  Consumer<ContentProvider>(
                    builder: (context, contentProvider, child) {
                      final contents = contentProvider.contents[
                              '$categoryId-${index + 1}'] ??
                          [];

                      if (contents.isNotEmpty &&
                          contents.first.image != null) {
                        return _buildImage(contents.first.image, context);
                      }

                      return SizedBox.shrink();
                    },
                  ),
                  Text(
                    Helpers.capitalizeTitle(subcategory.name),
                    style: TextStyle(
                      fontSize: Provider.of<SettingsProvider>(context).fontSize * 1.5, // Subheading scale
                      color: appBarColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Consumer<ContentProvider>(
                    builder: (context, contentProvider, child) {
                      final contents = contentProvider.contents[
                              '$categoryId-${index + 1}'] ??
                          [];

                      if (contents.isEmpty) {
                        return const Text('No content available.');
                      }

                      final firstItem = contents.first;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (firstItem.description != null &&
                              firstItem.description!.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                firstItem.description!,
                                style: TextStyle(
                                  fontSize: Provider.of<SettingsProvider>(context).fontSize * 1.1, // Description scale
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          _buildContentItem(firstItem, context),
                          ...contents.skip(1).map((contentItem) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: _buildContentItem(contentItem, context),
                            );
                          }).toList(),
                        ],
                      );
                    },
                  ),
                  Divider(
                    color: secondaryColor,
                    thickness: 0.5,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildImage(String? imageName, BuildContext context) {
    if (imageName == null) return SizedBox.shrink();

    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final imagePath = configProvider.getImagePath(imageName);

    if (imagePath != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.asset(
          'assets/$imagePath',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Text('Image not found');
          },
        ),
      );
    } else {
      return Text('Image not found');
    }
  }

  Widget _buildContentItem(ContentItem contentItem, BuildContext context) {
    final fontSize = Provider.of<SettingsProvider>(context).fontSize;

    if (contentItem.content.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (contentItem.heading != null && contentItem.heading!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              Helpers.capitalizeTitle(contentItem.heading!),
              style: TextStyle(
                fontSize: fontSize + 4, // Heading scale
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ...contentItem.content.map((quote) {
          if (quote.type == 'subheading') {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    Helpers.capitalizeTitle(quote.text),
                    style: TextStyle(
                      fontSize: fontSize + 2, // Subheading scale
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...?quote.content?.map((nestedQuote) {
                  if (nestedQuote.type == 'image') {
                    return _buildImage(nestedQuote.text, context);
                  }
                  return _buildQuote(nestedQuote, context, fontSize);
                }).toList(),
              ],
            );
          } else if (quote.type == 'image') {
            return _buildImage(quote.text, context);
          } else {
            return _buildQuote(quote, context, fontSize);
          }
        }).toList(),
      ],
    );
  }

  Widget _buildQuote(Quote quote, BuildContext context, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        Helpers.capitalizeTitle(quote.text),
        style: TextStyle(
          fontSize: fontSize, // Base text size
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
