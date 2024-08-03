// image_model.dart
class ImageModel {
  final String url;
  final String description;

  ImageModel({required this.url, required this.description});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      url: json['url'],
      description: json['description'],
    );
  }
}
