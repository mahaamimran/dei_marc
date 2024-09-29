import 'package:dei_marc/models/content_item.dart';

class Subcategory {
  final String name;
  final String? description; 
  final List<ContentItem> content;

  Subcategory({
    required this.name,
    this.description,
    required this.content,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    var contentList = (json['content'] as List?)
            ?.map((i) => ContentItem.fromJson(i))
            .toList() ??
        [];

    return Subcategory(
      name: json['name'],
      description: json['description'], 
      content: contentList,
    );
  }
}
