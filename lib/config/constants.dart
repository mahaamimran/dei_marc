// ignore_for_file: constant_identifier_names

class Constants {
  // SharedPreferences Keys
  static const String FONT_SIZE_KEY = 'fontSize';
  static const String FONT_FAMILY_KEY = 'fontFamily';
  static const String IS_GRID_VIEW_KEY = 'isGridView';
  static const String IS_LIST_VIEW_KEY = 'isListView';

  // Font Family Options
  static const String FONT_FAMILY_RALEWAY = 'Raleway';
  static const String FONT_FAMILY_ROBOTO = 'Roboto';
  static const String FONT_FAMILY_LEXEND = 'Lexend';

  // Font Size Limits
  static const double FONT_SIZE_MIN = 10.0;
  static const double FONT_SIZE_MAX = 32.0;

  // Other Constants
  static const List<String> FONT_FAMILIES = [
    FONT_FAMILY_RALEWAY,
    FONT_FAMILY_ROBOTO,
    FONT_FAMILY_LEXEND,
  ];

  // Content Keys
  static const String SUBHEADING = 'subheading';
  static const String IMAGE = 'image';
  static const String VIDEO = 'video';
  static const String BULLET = 'bullet';
  static const String QUOTE = 'quote';
  static const String BOLD = 'bold';
  static const String PARAGRAPH = 'paragraph';

  // Exceptions for Title Capitalization
  static const List<String> TITLE_EXCEPTIONS = [
    'an',
    'and',
    'or',
    'the',
    'of',
    'in',
    'to',
    'that',
    'by',
  ];
}
