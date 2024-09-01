class AssetPaths {
   static const List<String> bookCovers = [
    'assets/data/images/book_covers/toolkit1.png',
    'assets/data/images/book_covers/toolkit2.png',
  ];
  static const String booksJson = 'assets/data/books/books.json';
  static const String placeholderImage = 'assets/data/images/placeholder.png';
  static String categoriesJson(String bookId) => 'assets/data/categories/book${bookId}_categories.json';
  static String subcategoriesJson(String bookId, int categoryId) => 'assets/data/subcategories/book${bookId}_cat${categoryId}_subcategories.json';
  static String contentJson(String bookId, int categoryId, int subcategoryId) => 'assets/data/contents/book$bookId/book${bookId}_cat${categoryId}_sub${subcategoryId}_content.json';
  static String image(String imagePath) => 'assets/$imagePath';
  static String launchScreenBackground = 'assets/launch_screen/launch_screen.png';  
}
