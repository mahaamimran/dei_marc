import 'package:flutter/material.dart';
import 'package:dei_marc/models/subcategory.dart';

class JumpToCategory extends StatelessWidget {
  final List<Subcategory> subcategories;
  final Function(int) onCategorySelected;

  // add category name
  // color

  const JumpToCategory({
    Key? key,
    required this.subcategories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Jump to Subcategory',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ...List.generate(subcategories.length, (index) {
              final subcategory = subcategories[index];
              return ListTile(
                title: Text(subcategory.name),
                onTap: () => onCategorySelected(index),
              );
            }),
          ],
        ),
      ),
    );
  }
}
