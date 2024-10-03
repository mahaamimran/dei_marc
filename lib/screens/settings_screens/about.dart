import 'dart:convert';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/constants.dart';
import 'package:dei_marc/models/content_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  List<ContentItem> aboutContents = [];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    final String response = await rootBundle.loadString(AssetPaths.aboutContentPath);
    final data = json.decode(response);
    var contentList = data['content'] as List;
    setState(() {
      aboutContents = contentList.map((item) => ContentItem.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          'About',
          style: TextStyles.appBarTitle.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: aboutContents.map((aboutContent) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aboutContent.heading!,
                      style: TextStyles.heading(context).copyWith(fontSize: 16),
                    ),
                    ...aboutContent.content.map((content) {
                      if (content.type == Constants.PARAGRAPH) {
                        return Text(
                          content.text,
                          style: TextStyles.content(context).copyWith(fontSize: 16),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
