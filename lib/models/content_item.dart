import 'package:dei_marc/models/quote.dart';

class ContentItem {
  final String? category;
  final String? description;
  final String? heading;
  final List<Quote> content;
  final String? image; // Add image field

  ContentItem({
    this.category,
    this.description,
    this.heading,
    required this.content,
    this.image,
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
      image: null, // Handle image parsing in ContentProvider
    );
  }
}
