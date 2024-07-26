import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/screens/home_screen.dart';
import 'package:dei_marc/screens/splash_screen.dart';
import 'package:dei_marc/providers/book_provider.dart';
import 'package:dei_marc/providers/category_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: MaterialApp(
        title: 'DEI MARC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(), // Set SplashScreen as the initial route
        routes: {
          '/home': (context) => const HomeScreen(),
          // Add other routes here as necessary
        },
      ),
    );
  }
}
