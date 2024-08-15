class AssetPaths {
  static const String booksJson = 'assets/data/books/books.json';
  static const String placeholderImage = 'assets/images/placeholder.png';

  static String categoriesJson(String bookId) => 'assets/data/categories/book${bookId}_categories.json';
  static String subcategoriesJson(String bookId, int categoryId) => 'assets/data/subcategories/book${bookId}_cat${categoryId}_subcategories.json';
  static String contentJson(String bookId, int categoryId, int subcategoryId) => 'assets/data/contents/book$bookId/book${bookId}_cat${categoryId}_sub${subcategoryId}_content.json';
}
