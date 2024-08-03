import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/category_provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'content_screen.dart';

class CategoryScreen extends StatefulWidget {
  final String bookFileName;
  final Color appBarColor; // Add a parameter for the AppBar color
  final Color secondaryColor; // Add a parameter for the secondary color

  const CategoryScreen({
    super.key,
    required this.bookFileName,
    required this.appBarColor,
    required this.secondaryColor,
  });

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool _isGridView = true; // Toggle for list/grid view

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          CategoryProvider()..loadCategories(widget.bookFileName),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor:
                widget.appBarColor, // Use the passed color for the AppBar
            //foregroundColor: BasicColors.appBarForeground,
            title: const Text('Categories', style: TextStyles.appBarTitle),
            actions: [
              IconButton(
                icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                onPressed: () {
                  setState(() {
                    _isGridView = !_isGridView;
                  });
                },
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              if (categoryProvider.categories.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12.0,
                  ),
                  Expanded(
                    child: _isGridView
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: categoryProvider.categories.length,
                            itemBuilder: (context, index) {
                              final category =
                                  categoryProvider.categories[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContentScreen(
                                        appBarColor: widget.appBarColor,
                                        secondaryColor: widget.secondaryColor,
                                        bookId: widget.bookFileName,
                                        categoryId: index +
                                            1, // Pass the index of the category
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: widget.secondaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Category ${index + 1}',
                                          style: TextStyles.caption.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: widget.appBarColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Container(
                                          height: 2.0,
                                          width: 40.0,
                                          color: widget.appBarColor,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          category.name,
                                          style: TextStyles.caption,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: categoryProvider.categories.length,
                            itemBuilder: (context, index) {
                              final category =
                                  categoryProvider.categories[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContentScreen(
                                        appBarColor: widget.appBarColor,
                                        secondaryColor: widget.secondaryColor,
                                        bookId: widget.bookFileName,
                                        categoryId: index + 1,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  color: widget.secondaryColor,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    title: Text(
                                      'Category ${index + 1}',
                                      style: TextStyles.caption.copyWith(
                                        color: widget.appBarColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      category.name,
                                      style: TextStyles.caption.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
