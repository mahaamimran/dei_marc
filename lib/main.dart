import 'package:dei_marc/providers/config_provider.dart';
import 'package:dei_marc/providers/content_provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/providers/subcategory_provider.dart';
import 'package:dei_marc/screens/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/screens/splash_screen.dart';
import 'package:dei_marc/providers/book_provider.dart';
import 'package:dei_marc/providers/category_provider.dart';
import 'package:dei_marc/providers/bookmark_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => SubcategoryProvider()),
        ChangeNotifierProvider(create: (_) => ConfigProvider()..loadConfig()),
      ],
      child: MaterialApp(
        title: 'DEI MARC',
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const TabBarScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
