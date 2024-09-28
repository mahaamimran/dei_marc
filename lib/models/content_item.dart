import 'package:dei_marc/models/quote.dart';

class ContentItem {
  final String? category;
  final String? description;
  final String? heading;
  final String? type;
  final String? text;
  final List<Quote> content;
  final String? image;
  final String? caption; // Add caption field

  ContentItem({
    this.category,
    this.description,
    this.heading,
    this.type,
    this.text,
    required this.content,
    this.image,
    this.caption, // Add caption to constructor
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      category: json['category'],
      description: json['description'],
      heading: json['heading'],
      type: json['type'],
      text: json['text'],
      content: (json['content'] as List<dynamic>?)
              ?.map((quoteJson) => Quote.fromJson(quoteJson))
              .toList() ??
          [],
      image: (json['image'] as List<dynamic>?)?.firstWhere(
        (img) => img['type'] == 'image',
        orElse: () => null,
      )?['text'],
      caption: (json['image'] as List<dynamic>?)?.firstWhere(
        (img) => img['type'] == 'caption',
        orElse: () => null,
      )?['text'], // Add caption parsing logic
    );
  }
}
