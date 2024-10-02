import 'dart:convert';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/constants.dart';
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
  List<AboutContent> aboutContents = [];

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
      aboutContents = contentList.map((item) => AboutContent.fromJson(item)).toList();
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
                    _buildSectionTitle(aboutContent.heading),
                    ...aboutContent.content.map((content) {
                      if (content.type == 'paragraph') {
                        return _buildParagraph(content.text);
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyles.appTitle.copyWith(fontSize: 18, color: Colors.black),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: Constants.FONT_FAMILY_LEXEND,
          fontSize: 16, 
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class AboutContent {
  final String heading;
  final List<Content> content;

  AboutContent({required this.heading, required this.content});

  factory AboutContent.fromJson(Map<String, dynamic> json) {
    var contentList = json['content'] as List;
    List<Content> contentItems =
        contentList.map((item) => Content.fromJson(item)).toList();
    return AboutContent(
      heading: json['heading'],
      content: contentItems,
    );
  }
}

class Content {
  final String type;
  final String text;

  Content({required this.type, required this.text});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      type: json['type'],
      text: json['text'],
    );
  }
}
