import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/models/subcategory.dart';

class JumpToCategory extends StatelessWidget {
  final List<Subcategory> subcategories;
  final Function(int) onCategorySelected;
  final String categoryName;
  final Color backgroundColor;

  const JumpToCategory({
    super.key,
    required this.subcategories,
    required this.onCategorySelected,
    required this.categoryName,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          color: backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(categoryName, style: TextStyles.appTitle),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: subcategories.length,
                    itemBuilder: (context, index) {
                      final subcategory = subcategories[index];
                      final displayName = subcategory.name;
                      // Helpers.capitalizeTitle(subcategory.name);

                      return Column(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                onCategorySelected(index);
                              },
                              splashColor: backgroundColor
                                  .withOpacity(0.3), // Ripple effect
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 5,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        '${index + 1}. $displayName',
                                        style: TextStyles.appCaption.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (index != subcategories.length - 1)
                            const Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Colors.grey,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
