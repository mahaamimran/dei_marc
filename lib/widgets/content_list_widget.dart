// ignore_for_file: avoid_print

import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/constants.dart';
import 'package:dei_marc/utils/connection_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:dei_marc/models/content_item.dart';
import 'package:dei_marc/models/quote.dart';
import 'package:dei_marc/providers/config_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/providers/subcategory_provider.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/config/text_styles.dart';

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
              children: subcategoryProvider.subcategories.asMap().entries.map((entry) {
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
                                Helpers.capitalizeTitle(categoryName)
                                    .toUpperCase(),
                                style: TextStyles.heading(context).copyWith(
                                  fontSize: Provider.of<SettingsProvider>(context)
                                          .fontSize *
                                      1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                      // Image before subcategory title
                      Consumer<ContentProvider>(
                        builder: (context, contentProvider, child) {
                          final contents = contentProvider
                                  .contents['$categoryId-${index + 1}'] ??
                              [];

                          if (contents.isNotEmpty &&
                              contents.first.image != null) {
                            return _buildImage(contents.first.image, context);
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                      Text(
                        Helpers.capitalizeTitle(subcategory.name),
                        style: TextStyles.subheading(context).copyWith(
                          fontSize:
                              Provider.of<SettingsProvider>(context).fontSize *
                                  1.5,
                          color: appBarColor,
                        ),
                      ),
                      Consumer<ContentProvider>(
                        builder: (context, contentProvider, child) {
                          final contents = contentProvider
                                  .contents['$categoryId-${index + 1}'] ??
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
                                    style: TextStyles.content(context).copyWith(
                                      fontSize:
                                          Provider.of<SettingsProvider>(context)
                                                  .fontSize *
                                              1.1,
                                    ),
                                  ),
                                ),
                              _buildContentItem(firstItem, context),
                              ...contents.skip(1).map((contentItem) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: _buildContentItem(contentItem, context),
                                );
                              }),
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
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(String? imageName, BuildContext context) {
    if (imageName == null) return const SizedBox.shrink();

    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final imagePath = configProvider.getImagePath(imageName);

    if (imagePath != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.asset(
          AssetPaths.image(imagePath),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('Error loading image: $error'); 
            return const Text('Image not found');
          },
        ),
      );
    } else {
      print('Image path is null for $imageName'); // Add this line for logging
      return const Text('Image not found');
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
              style: TextStyles.heading(context).copyWith(
                fontSize: fontSize + 4,
              ),
            ),
          ),
        ...contentItem.content.map((quote) {
          if (quote.type == Constants.SUBHEADING) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    Helpers.capitalizeTitle(quote.text),
                    style: TextStyles.subheading(context).copyWith(
                      fontSize: fontSize + 2,
                    ),
                  ),
                ),
                ...?quote.content?.map((nestedQuote) {
                  if (nestedQuote.type == Constants.IMAGE) {
                    return _buildImage(nestedQuote.text, context);
                  } else if (nestedQuote.type == Constants.VIDEO) {
                    return _buildVideo(nestedQuote.text, context);
                  }
                  return _buildQuote(nestedQuote, context, fontSize);
                }),
              ],
            );
          } else if (quote.type == Constants.IMAGE) {
            return _buildImage(quote.text, context);
          } else if (quote.type == Constants.VIDEO) {
            return _buildVideo(quote.text, context);
          } else {
            return _buildQuote(quote, context, fontSize);
          }
        }),
      ],
    );
  }

  Widget _buildQuote(Quote quote, BuildContext context, double fontSize) {
    // Determine if the quote is a bullet or a standard quote
    if (quote.type == Constants.BULLET) {
      // Handle bullet points
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: fontSize * 0.2),
              child: Icon(
                Icons.double_arrow_rounded,
                size: fontSize,
                color: appBarColor,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                quote.text,
                style: TextStyles.bullet(context).copyWith(fontSize: fontSize),
              ),
            ),
          ],
        ),
      );
    } else if (quote.type == Constants.QUOTE) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.grey.shade400,
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.format_quote_rounded,
                size: 20,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  quote.text,
                  style: TextStyles.quote(context).copyWith(fontSize: fontSize),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (quote.type == Constants.BOLD) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          Helpers.capitalizeTitle(quote.text),
          style: TextStyles.bold(context).copyWith(fontSize: fontSize),
        ),
      );
    } else if (quote.type == Constants.PARAGRAPH) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          quote.text,
          style: TextStyles.content(context).copyWith(fontSize: fontSize),
        ),
      );
    }
    else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          quote.text,
          style: TextStyles.content(context).copyWith(fontSize: fontSize, color: Colors.red),
        ),
      );
    }
  }

  Widget _buildVideo(String? videoUrl, BuildContext context) {
    if (videoUrl == null) return const SizedBox.shrink();

    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId == null) return const Text('Invalid video URL');

    return FutureBuilder<bool>(
      future: ConnectionUtil().isConnected(), // Check internet connection
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the connection check is ongoing, you can show a loading indicator
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data == true) {
          // If connected, show the embedded video
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                  controlsVisibleAtStart: true,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Theme.of(context).primaryColor,
            ),
          );
        } else {
          // If not connected, show a clickable link
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () => _launchURL(videoUrl),
              child: const Text(
                'No internet connection. Click here to watch the video.',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _launchURL(String url) async {
    try {
       _launchURL(url);
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
