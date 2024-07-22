// contants so that we can use them in multiple places so we can use them like this:
// Image.asset(AssetPaths.placeholderImage)

class AssetPaths {
  static const String booksJson = 'assets/data/books/books.json';
  static const String placeholderImage = 'assets/images/placeholder.png';

  static String categoriesJson(String bookId) => 'assets/data/categories/${bookId}_categories.json';
  static String subcategoriesJson(String bookId, String categoryId) => 'assets/data/subcategories/${bookId}_cat${categoryId}_subcategories.json';
  static String contentJson(String bookId, String categoryId, String subcategoryId) => 'assets/data/contents/${bookId}_cat${categoryId}_sub${subcategoryId}_content.json';
}
