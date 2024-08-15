import 'package:dei_marc/models/quote.dart';

class ContentItem {
  final String? category;
  final String? description;
  final String? heading;
  final List<Quote> content;

  ContentItem({
    this.category,
    this.description,
    this.heading,
    required this.content,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    var contentList = (json['content'] as List?)
        ?.map((i) => Quote.fromJson(i))
        .toList() ?? [];

    return ContentItem(
      category: json['category'],
      description: json['description'],
      heading: json['heading'],
      content: contentList,
    );
  }
}
