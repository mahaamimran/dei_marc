import 'package:dei_marc/models/quote.dart';

class ContentItem {
  final String text;
  final String name;
  final List<Quote> content;

  ContentItem({required this.text, required this.name, required this.content});

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    var quoteList = (json['content'] as List).map((i) => Quote.fromJson(i)).toList();
    return ContentItem(text: json['text'], name: json['name'], content: quoteList);
  }
}
