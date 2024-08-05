class Quote {
  final String type; // subheading, bullet, description 
  final String text;

  Quote({required this.type, required this.text});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(type: json['type'], text: json['text']);
  }
}
