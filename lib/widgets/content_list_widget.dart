import 'package:dei_marc/models/quote.dart';
import 'package:dei_marc/widgets/content_widgets/caption_widget.dart';
import 'package:dei_marc/widgets/content_widgets/description_widget.dart';
import 'package:dei_marc/widgets/content_widgets/subcategory_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/models/content_item.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/providers/subcategory_provider.dart';
import 'package:dei_marc/providers/config_provider.dart';
import 'package:dei_marc/widgets/content_widgets/heading_widget.dart';
import 'package:dei_marc/widgets/content_widgets/subheading_widget.dart';
import 'package:dei_marc/widgets/content_widgets/paragraph_widget.dart';
import 'package:dei_marc/widgets/content_widgets/bullet_widget.dart';
import 'package:dei_marc/widgets/content_widgets/image_widget.dart';
import 'package:dei_marc/widgets/content_widgets/player_widget.dart';
import 'package:dei_marc/widgets/content_widgets/quote_widget.dart';
import 'package:dei_marc/widgets/content_widgets/bold_widget.dart';
import 'package:dei_marc/widgets/content_widgets/category_title_widget.dart';
import 'package:dei_marc/config/constants.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/widgets/content_widgets/pdf_download_button.dart';

class ContentListWidget extends StatelessWidget {
  final int categoryId;
  final Color appBarColor;
  final Color secondaryColor;
  final String categoryName;
  final ScrollController scrollController;
  final Map<String, GlobalKey> keyMap;

  const ContentListWidget({
    super.key,
    required this.categoryId,
    required this.appBarColor,
    required this.secondaryColor,
    required this.categoryName,
    required this.scrollController,
    required this.keyMap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SubcategoryProvider>(
      builder: (context, subcategoryProvider, child) {
        if (subcategoryProvider.subcategories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        keyMap.clear();

        return Scrollbar(
          interactive: true,
          thickness: 5,
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Category name
                CategoryTitleWidget(
                  categoryName: categoryName,
                  barColor: appBarColor,
                  textColor: appBarColor,
                ),
                const SizedBox(height: 16),

                // 2. Image, Caption, Deck of Slides (if available)
                Consumer<ContentProvider>(
                  builder: (context, contentProvider, child) {
                    final contents =
                        contentProvider.contents['$categoryId-1'] ?? [];

                    if (contents.isNotEmpty) {
                      final firstItem = contents.first;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (firstItem.image != null)
                            ImageWidget(imageName: firstItem.image),
                          if (firstItem.caption != null &&
                              firstItem.caption!.isNotEmpty)
                            CaptionWidget(
                              text: firstItem.caption!,
                              fontSize: Provider.of<SettingsProvider>(context)
                                  .fontSize,
                            ),

                          // Deck of Slides (if available)
                          if (firstItem.deckOfSlides != null)
                            Consumer<ConfigProvider>(
                              builder: (context, configProvider, child) {
                                final deckOfSlidesUrl = configProvider
                                    .getPdfPath(firstItem.deckOfSlides);

                                if (deckOfSlidesUrl != null) {
                                  return PDFDownloadButton(
                                    text: 'Download Deck of Slides',
                                    secondaryColor: secondaryColor,
                                    primaryColor: appBarColor,
                                    pdfUrl: deckOfSlidesUrl,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // 3. Show Main Description before Subcategories using DescriptionWidget
                if (subcategoryProvider.description != null &&
                    subcategoryProvider.description!.isNotEmpty)
                  DescriptionWidget(
                    description: subcategoryProvider.description!,
                    fontSize: Provider.of<SettingsProvider>(context).fontSize,
                  ),

                // 4. Iterate through subcategories
                ...subcategoryProvider.subcategories
                    .asMap()
                    .entries
                    .map((entry) {
                  final index = entry.key;
                  final subcategory = entry.value;
                  final key = GlobalKey();
                  keyMap['$categoryId-$index'] = key;

                  return Padding(
                    key: key,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 5. Subcategory Name
                        SubcategoryNameWidget(
                          subcategoryName: subcategory.name,
                          color: appBarColor,
                        ),

                        const SizedBox(height: 16),

                        // Render remaining content items
                        Consumer<ContentProvider>(
                          builder: (context, contentProvider, child) {
                            final contents = contentProvider
                                    .contents['$categoryId-${index + 1}'] ??
                                [];

                            if (contents.isEmpty) {
                              return const Text('No content available.');
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: contents.skip(1).map((contentItem) {
                                return _buildContentItem(contentItem, context);
                              }).toList(),
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
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContentItem(ContentItem contentItem, BuildContext context) {
    final fontSize = Provider.of<SettingsProvider>(context).fontSize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading Widget
        if (contentItem.heading != null && contentItem.heading!.isNotEmpty)
          HeadingWidget(heading: contentItem.heading!, fontSize: fontSize),

        // Render nested content like paragraphs, bullets, quotes, etc.
        ...contentItem.content.map((quote) {
          if (quote.type == Constants.SUBHEADING) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubheadingWidget(
                  subheading: quote.text,
                  fontSize: fontSize,
                ),
                if (quote.content != null)
                  ...quote.content!.map((nestedQuote) {
                    return _buildNestedContent(nestedQuote, context, fontSize);
                  }),
              ],
            );
          } else {
            return _buildNestedContent(quote, context, fontSize);
          }
        }),
      ],
    );
  }

  Widget _buildNestedContent(
      Quote quote, BuildContext context, double fontSize) {
    if (quote.type == Constants.PARAGRAPH) {
      return ParagraphWidget(
        text: quote.text,
        fontSize: fontSize,
        highlightColor: appBarColor,
      );
    } else if (quote.type == Constants.IMAGE) {
      return ImageWidget(imageName: quote.text);
    } else if (quote.type == Constants.VIDEO) {
      return PlayerWidget(videoUrl: quote.text);
    } else if (quote.type == Constants.BULLET) {
      return BulletWidget(
        text: quote.text,
        bulletColor: appBarColor,
        fontSize: fontSize,
      );
    } else if (quote.type == Constants.QUOTE) {
      return QuoteWidget(
        quote: quote.text,
        fontSize: fontSize,
        appBarColor: appBarColor,
      );
    } else if (quote.type == Constants.BOLD) {
      return BoldWidget(text: quote.text, fontSize: fontSize);
    } else if (quote.type == Constants.CAPTION) {
      return CaptionWidget(text: quote.text, fontSize: fontSize);
    } else if (quote.type == 'pdf') {
      return PDFDownloadButton(
        text: 'Download',
        secondaryColor: secondaryColor,
        primaryColor: appBarColor,
        pdfUrl: quote.text,
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          quote.text,
          style: TextStyles.content(context).copyWith(fontSize: fontSize),
        ),
      );
    }
  }
}
