import 'package:dei_marc/models/quote.dart';

class ContentItem {
  final String? category;
  final String? description;
  final String? heading;
  final List<Quote> content;
  final String? image;

  ContentItem({
    this.category,
    this.description,
    this.heading,
    required this.content,
    this.image,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      category: json['category'],
      description: json['description'],
      heading: json['heading'],
      content: (json['content'] as List<dynamic>?)
              ?.map((quoteJson) => Quote.fromJson(quoteJson))
              .toList() ??
          [],
      image: (json['image'] as List<dynamic>?)
              ?.firstWhere(
                (img) => img['type'] == 'image',
                orElse: () => null,
              )?['text'],
    );
  }
}

