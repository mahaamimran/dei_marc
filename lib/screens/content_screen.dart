import 'package:dei_marc/models/subcategory.dart';
import 'package:dei_marc/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';
import 'package:dei_marc/providers/subcategory_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/config/enums.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/widgets/content_list_widget.dart';
import 'package:dei_marc/widgets/font_adjuster_widget.dart';
import 'package:dei_marc/widgets/jump_to_category.dart';
import 'package:dei_marc/config/color_constants.dart';

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
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final subcategoryProvider =
        Provider.of<SubcategoryProvider>(context, listen: false);
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);
    final configProvider = Provider.of<ConfigProvider>(context, listen: false);

    await subcategoryProvider.loadSubcategories(widget.bookId, widget.categoryId);

    for (int i = 0; i < subcategoryProvider.subcategories.length; i++) {
      await contentProvider.loadContent(widget.bookId, widget.categoryId, i + 1);

      final contents =
          contentProvider.contents['${widget.categoryId}-${i + 1}'] ?? [];

      for (var content in contents) {
        if (content.image != null) {
          final imagePath = configProvider.getImagePath(content.image!);
          if (imagePath != null) {
            await precacheImage(AssetImage('assets/$imagePath'), context);
          }
        }
      }
    }
  }

  void _scrollToIndex(int index) {
    final key = _keyMap['${widget.categoryId}-$index'];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subcategoryProvider = Provider.of<SubcategoryProvider>(context);
    final contentProvider = Provider.of<ContentProvider>(context);
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    final String bookmarkId = '${widget.bookId}-${widget.categoryId}';
    final bool isBookmarked = bookmarkProvider.isBookmarked(bookmarkId);

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
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: () => _showFontSizeAdjuster(context),
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => _showCategoryList(
              context,
              subcategoryProvider.subcategories,
            ),
          ),
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
            ),
            onPressed: () {
              if (isBookmarked) {
                bookmarkProvider.removeBookmark(bookmarkId);
              } else {
                bookmarkProvider.addBookmark(bookmarkId);
              }
            },
          ),
        ],
      ),
      body: _buildBody(subcategoryProvider, contentProvider),
    );
  }

  Widget _buildBody(
      SubcategoryProvider subcategoryProvider, ContentProvider contentProvider) {
    if (subcategoryProvider.dataStatus == DataStatus.loading ||
        contentProvider.dataStatus == DataStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (subcategoryProvider.dataStatus == DataStatus.failure ||
        contentProvider.dataStatus == DataStatus.failure) {
      return const Center(
        child: Text(
          'Failed to load content',
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      );
    } else if (subcategoryProvider.dataStatus == DataStatus.loaded &&
        contentProvider.dataStatus == DataStatus.loaded) {
      return ContentListWidget(
        categoryId: widget.categoryId,
        appBarColor: widget.appBarColor,
        secondaryColor: widget.secondaryColor,
        categoryName: widget.categoryName,
        scrollController: _scrollController,
        keyMap: _keyMap,
      );
    } else {
      return Container();
    }
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
          categoryName: widget.categoryName,
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

  void _showFontSizeAdjuster(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) {
        return FontSizeAdjusterWidget(
          appBarColor: widget.appBarColor,
          secondaryColor: widget.secondaryColor,
        );
      },
    );
  }
}
