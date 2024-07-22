import 'package:dei_marc/providers/category_provider.dart';
import 'package:dei_marc/screens/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/book_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';

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
        ChangeNotifierProvider(create: (_) => ContentProvider()),
      ],
      child: const MaterialApp(
        home: TabBarScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
