import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/screens/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/screens/splash_screen.dart';
import 'package:dei_marc/providers/book_provider.dart';
import 'package:dei_marc/providers/category_provider.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';
import 'package:dei_marc/providers/image_provider.dart' as my_image_provider;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()..loadBooks()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp(
        title: 'DEI MARC',
        home: const SplashScreen(),
        routes: {
          // not home screen, tab bar screen consists of home screen
          '/home': (context) => const TabBarScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
