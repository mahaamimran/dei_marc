import 'package:flutter/material.dart';

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

  static String getAppBarTitle(String bookId) {
    switch (bookId) {
      case '1':
        return 'Categories';
      case '2':
        return 'Groups';
      case '3':
        return 'Modules';
      default:
        return 'Categories';
    }
  }

  static String capitalizeTitle(String input) {
    const List<String> exceptions = [
      "of",
      "| the",
      "in",
      "and",
      "| a",
      "an",
      "min"
      "on"
    ];
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (i == 0 || !exceptions.contains(words[i].toLowerCase())) {
        if (words[i] != words[i].toUpperCase()) {
          words[i] =
              words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
        }
      } else {
        words[i] = words[i].toLowerCase();
      }
    }

    return words.join(' ');
  }

  static List<TextSpan> highlightCompanies(
      String text, TextStyle baseStyle, Color highlightColor) {
    final companies = [
      'Jazz',
      'Bank Alfalah',
      'Telenor',
      'British Council',
      'Abacus',
      'Unilever',
      'Teradata',
      'S&P Global',
      'Interloop',
      'Finca',
      'Hashoo Group',
      'PTCL',
      'Engro',
      'JS Bank',
      'Mobilink Microfinance Bank',
      'Microfinance Bank Limited',
      'HRSG',
      'PPAF',
      'TPLCorp',
      'Feroze1888',
      'EPCL',
      'MMBL',
      'TPL Corp',
    ];

    // Create a regex pattern that matches any of the companies, case-insensitive
    final pattern = RegExp(
        companies.map((company) => RegExp.escape(company)).join('|'),
        caseSensitive: false);

    List<TextSpan> spans = [];

    // Split the text using the RegExp
    text.splitMapJoin(
      pattern,
      onMatch: (match) {
        // If it's a match, highlight the company
        spans.add(TextSpan(
            text: match.group(0),
            style: baseStyle.copyWith(color: highlightColor)));
        return match.group(0) ?? '';
      },
      onNonMatch: (nonMatch) {
        // Otherwise, use the normal style
        spans.add(TextSpan(text: nonMatch, style: baseStyle));
        return nonMatch;
      },
    );

    return spans;
  }

  static String getVolume(String bookFileName) {
    switch (bookFileName) {
      case '1':
        return 'I';
      case '2':
        return 'II';
      case '3':
        return 'III';
      default:
        return '';
    }
  }
}
