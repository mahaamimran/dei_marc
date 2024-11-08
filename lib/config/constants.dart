// ignore_for_file: constant_identifier_names

class Constants {
  // Reposive
  static const double MOBILE_TITLE_FONT_SIZE = 18.0;
  static const double TABLET_TITLE_FONT_SIZE = 24.0;

  static const double MOBILE_PADDING = 8.0;
  static const double TABLET_PADDING = 16.0;
  
  // SharedPreferences Keys
  static const String FONT_SIZE_KEY = 'fontSize';
  static const String FONT_FAMILY_KEY = 'fontFamily';
  static const String IS_GRID_VIEW_KEY = 'isGridView';
  static const String IS_LIST_VIEW_KEY = 'isListView';
  static const String BOOKMARKS_KEY = 'bookmarks';

  // Font Family Options
  static const String FONT_FAMILY_RALEWAY = 'Raleway';
  static const String FONT_FAMILY_ROBOTO = 'Roboto';
  static const String FONT_FAMILY_LEXEND = 'Lexend';

  // Font Size Limits
  static const double FONT_SIZE_MIN = 9.0;
  static const double FONT_SIZE_MAX = 33.0;

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
  static const String CAPTION = 'caption';
  static const String DECKOFSLIDES = 'deckofslides';
  static const String DESCRIPTION = 'description';
  static const String HEADING = 'heading';
  static const String PDF = 'pdf';
  static const String COMPLETEPDF = 'completepdf';
  static const String ABOUT = 'About';
}
