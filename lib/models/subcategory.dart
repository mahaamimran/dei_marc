import 'package:dei_marc/models/content_item.dart';

class Subcategory {
  final String name;
  final List<ContentItem> content;

  Subcategory({
    required this.name,
    required this.content,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    var contentList = (json['content'] as List?)
            ?.map((i) => ContentItem.fromJson(i))
            .toList() ??
        [];
    return Subcategory(
      name: json['name'],
      content: contentList,
    );
  }
}
