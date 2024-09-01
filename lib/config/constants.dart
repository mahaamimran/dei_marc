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

  // Content Item Types
  static const String CONTENT_TYPE_BULLET = 'bullet';
  static const String CONTENT_TYPE_QUOTE = 'quote';
  static const String CONTENT_TYPE_BOLD = 'bold';
  static const String CONTENT_TYPE_PARAGRAPH = 'paragraph';
  static const String CONTENT_TYPE_IMAGE = 'image';
  static const String CONTENT_TYPE_VIDEO = 'video';

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
