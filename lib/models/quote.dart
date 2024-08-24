class Quote {
  final String type;
  final String text;
  final List<Quote>? content;

  Quote({
    required this.type,
    required this.text,
    this.content,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      type: json['type'],
      text: json['text'],
      content: (json['content'] as List<dynamic>?)
          ?.map((quoteJson) => Quote.fromJson(quoteJson))
          .toList(),
    );
  }
}
