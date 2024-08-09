import 'package:dei_marc/config/color_constants.dart';
import 'package:dei_marc/models/subcategory.dart';
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
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _keyMap = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    final context = _keyMap[index]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

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
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.appBarColor,
          foregroundColor: Colors.white,
          toolbarHeight: 75.0,
          title: Text('Category ${widget.categoryId}',
              style: TextStyles.appBarTitle),
          actions: [
            Consumer<SubcategoryProvider>(
              builder: (context, subcategoryProvider, child) {
                return IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () => _showCategoryList(
                      context, subcategoryProvider.subcategories),
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
                _keyMap[index] = key;

                return Padding(
                  key: key,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subcategory.name.toUpperCase(),
                          style: TextStyles.heading.copyWith(
                            color: widget.appBarColor,
                          ),
                        ),
                        if (subcategory.description != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              subcategory.description!,
                              style: TextStyles.caption.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        FutureBuilder(
                          future: context.read<ContentProvider>().loadContent(
                              widget.bookId, widget.categoryId, index + 1),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            final contents =
                                context.read<ContentProvider>().contents[
                                        '${widget.categoryId}-${index + 1}'] ??
                                    [];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: contents.map((contentItem) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contentItem.heading,
                                        style: TextStyles.title,
                                      ),
                                      const SizedBox(height: 8.0),
                                      ...contentItem.content.map((quote) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Text(
                                            quote.text,
                                            style: TextStyles.caption.copyWith(
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Divider(
                          color: widget.secondaryColor,
                          thickness: 2.0,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showCategoryList(
      BuildContext context, List<Subcategory> subcategories) {
    // Determine the background color based on the book ID
    final int bookIdIndex =
        int.parse(widget.bookId) - 1; // Adjust if bookId is not zero-based
    final backgroundColor = ColorConstants
        .booksSecondary[bookIdIndex % ColorConstants.booksSecondary.length];

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) {
        return JumpToCategory(
          categoryName: 'Category ${widget.categoryId}', // Pass category name
          subcategories: subcategories,
          onCategorySelected: (index) {
            Navigator.pop(context);
            _scrollToIndex(index);
          },
          backgroundColor: backgroundColor, // Set dynamic background color
        );
      },
    );
  }
}
