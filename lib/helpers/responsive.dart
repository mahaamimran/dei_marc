
import 'package:dei_marc/config/constants.dart';
import 'package:flutter/material.dart';

class Responsive {
  static double fontSize(BuildContext context) {
    return isTablet(context) ? Constants.TABLET_TITLE_FONT_SIZE : Constants.MOBILE_TITLE_FONT_SIZE;
  }

  static double padding(BuildContext context) {
    return isTablet(context) ? Constants.TABLET_PADDING : Constants.MOBILE_PADDING;
  }

  static int gridColumnCount(BuildContext context) {
    return isTablet(context) ? 3 : 2;  // Example: 3 columns on tablet, 2 on mobile
  }

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.shortestSide >= 600; // Define tablet as having a minimum width of 600
  }
}
