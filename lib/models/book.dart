// book data model according to the json file
class Book {
  final int id;
  final int volume;
  final String title;
  final String author;
  final String citation;
  final String imagePath;

  Book({
    required this.id,
    required this.volume,
    required this.title,
    required this.author,
    required this.citation,
    required this.imagePath,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      volume: json['Volume'],
      title: json['title'],
      author: json['author'],
      citation: json['citation'],
      imagePath: json['image_path'],
    );
  }
}
