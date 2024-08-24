class Helpers {
  static String getTitle(String bookId) {
    switch (bookId) {
      case '1':
        return 'Category';
      case '2':
        return 'Group';
      case '3':
        return 'Module';
      default:
        return 'Category';
    }
  }

  static String capitalizeTitle(String input) {
    final List<String> exceptions = ['a', 'an', 'and', 'or', 'the', 'of', 'in', 'to', 'that', 'by'];

    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (i == 0 || !exceptions.contains(words[i].toLowerCase())) {
        // Capitalize the word if it's the first word or not in the exceptions list
        if (words[i] != words[i].toUpperCase()) {
          words[i] = words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
        }
      } else {
        // Otherwise, make it lowercase
        words[i] = words[i].toLowerCase();
      }
    }

    return words.join(' ');
  }
}
