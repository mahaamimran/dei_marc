import 'package:dei_marc/config/color_constants.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/models/content_item.dart';
import 'package:dei_marc/models/quote.dart';
import 'package:dei_marc/models/subcategory.dart';
import 'package:dei_marc/providers/config_provider.dart';
import 'package:dei_marc/widgets/jump_to_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/subcategory_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/config/text_styles.dart';

class ContentScreen extends StatefulWidget {
  final String bookId;
  final int categoryId;
  final Color appBarColor;
  final Color secondaryColor;
  final String categoryName;

  const ContentScreen({
    super.key,
    required this.bookId,
    required this.categoryId,
    required this.appBarColor,
    required this.secondaryColor,
    required this.categoryName,
  });

  @override
  _ContentScreenState createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _keyMap = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final subcategoryProvider =
        Provider.of<SubcategoryProvider>(context, listen: false);
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);
    final configProvider = Provider.of<ConfigProvider>(context, listen: false);

    subcategoryProvider
        .loadSubcategories(widget.bookId, widget.categoryId)
        .then((_) {
      for (int i = 0; i < subcategoryProvider.subcategories.length; i++) {
        contentProvider
            .loadContent(widget.bookId, widget.categoryId, i + 1)
            .then((_) {
          // Precache images for this content
          final contents =
              contentProvider.contents['${widget.categoryId}-${i + 1}'] ?? [];
          for (var content in contents) {
            if (content.image != null) {
              final imagePath = configProvider.getImagePath(content.image!);
              if (imagePath != null) {
                precacheImage(AssetImage('assets/$imagePath'), context);
              }
            }
          }
        });
      }
    });
  }

  void _scrollToIndex(int index) {
    final key = _keyMap['${widget.bookId}-${widget.categoryId}-$index'];
    if (key != null && key.currentContext != null) {
      final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
      final position =
          box.localToGlobal(Offset.zero, ancestor: context.findRenderObject());

      _scrollController.animateTo(
        _scrollController.offset + position.dy - kToolbarHeight,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildImage(String? imageName) {
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

  Widget _buildContentItem(ContentItem contentItem) {
    if (contentItem.content.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contentItem.content.map((quote) {
        if (quote.type == 'subheading') {
          // Render subheading and its nested content
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  quote.text,
                  style: TextStyles.subheading.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Render nested content (e.g., bullets)
              ...?quote.content?.map((nestedQuote) {
                return _buildQuote(nestedQuote);
              }).toList(),
            ],
          );
        } else {
          return _buildQuote(quote);
        }
      }).toList(),
    );
  }

  Widget _buildQuote(Quote quote) {
    switch (quote.type) {
      case 'image':
        return _buildImage(quote.text);
      case 'bullet':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• "),
              Expanded(
                child: Text(
                  quote.text,
                  style: TextStyles.caption.copyWith(
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        );
      case 'paragraph':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            quote.text,
            style: TextStyles.caption.copyWith(
              color: Colors.grey[800],
            ),
          ),
        );
      case 'subheading':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            quote.text,
            style: TextStyles.subheading.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            quote.text,
            style: TextStyles.caption.copyWith(
              color: Colors.grey[800],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: widget.appBarColor,
        foregroundColor: Colors.white,
        title: Text(
          '${Helpers.getTitle(widget.bookId)} ${widget.categoryId}',
          style: TextStyles.appBarTitle,
        ),
        actions: [
          Consumer<SubcategoryProvider>(
            builder: (context, subcategoryProvider, child) {
              return IconButton(
                icon: const Icon(Icons.list),
                onPressed: () => _showCategoryList(
                  context,
                  subcategoryProvider.subcategories,
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<SubcategoryProvider>(
        builder: (context, subcategoryProvider, child) {
          if (subcategoryProvider.subcategories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          _keyMap.clear();

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16.0),
            itemCount: subcategoryProvider.subcategories.length,
            itemBuilder: (context, index) {
              final subcategory = subcategoryProvider.subcategories[index];
              final key = GlobalKey();
              _keyMap['${widget.bookId}-${widget.categoryId}-$index'] = key;

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
                              color: widget.appBarColor,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                          const SizedBox(width: 18.0),
                          Expanded(
                            child: Text(
                              Helpers.capitalizeTitle(widget.categoryName)
                                  .toUpperCase(),
                              style: TextStyles.heading.copyWith(
                                color: Colors.black,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      Helpers.capitalizeTitle(subcategory.name),
                      style: TextStyles.heading.copyWith(
                        color: widget.appBarColor,
                      ),
                    ),
                    Consumer<ContentProvider>(
                      builder: (context, contentProvider, child) {
                        final contents = contentProvider.contents[
                                '${widget.categoryId}-${index + 1}'] ??
                            [];

                        if (contents.isEmpty) {
                          return const Text('No content available.');
                        }

                        final firstItem = contents.first;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (firstItem.image != null)
                              _buildImage(firstItem.image),
                            if (firstItem.description != null &&
                                firstItem.description!.isNotEmpty)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  firstItem.description!,
                                  style: TextStyles.caption.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            _buildContentItem(firstItem),
                            ...contents.skip(1).map((contentItem) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: _buildContentItem(contentItem),
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showCategoryList(
    BuildContext context,
    List<Subcategory> subcategories,
  ) {
    final int bookIdIndex = int.parse(widget.bookId) - 1;
    final backgroundColor = ColorConstants
        .booksSecondary[bookIdIndex % ColorConstants.booksSecondary.length];

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) {
        return JumpToCategory(
          categoryName:
              '${Helpers.getTitle(widget.bookId)} ${widget.categoryId}',
          subcategories: subcategories,
          onCategorySelected: (index) {
            Navigator.pop(context);
            Future.delayed(Duration(milliseconds: 200), () {
              _scrollToIndex(index);
            });
          },
          backgroundColor: backgroundColor,
        );
      },
    );
  }
}
