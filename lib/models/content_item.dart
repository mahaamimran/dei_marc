import 'package:dei_marc/models/quote.dart';

class ContentItem {
  final String heading;
  final List<Quote> content;

  ContentItem({required this.heading, required this.content});

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    var contentList = (json['content'] as List).map((i) => Quote.fromJson(i)).toList();
    return ContentItem(heading: json['heading'], content: contentList);
  }
}
