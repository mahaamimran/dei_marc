import 'dart:convert';
import 'package:dei_marc/config/constants.dart';
import 'package:dei_marc/models/content_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:dei_marc/providers/settings_provider.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  List<ContentItem> supportContents = [];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    final String response = await rootBundle.loadString(AssetPaths.supportContentPath);
    final data = json.decode(response);
    var contentList = data['content'] as List;
    setState(() {
      supportContents = contentList.map((item) => ContentItem.fromJson(item)).toList();
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
          'Support',
          style: TextStyles.appBarTitle.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: supportContents.map((supportContent) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      supportContent.heading!,
                      style: TextStyles.heading(context).copyWith(fontSize: 16),
                    ),
                    ...supportContent.content.map((content) {
                      if (content.type == Constants.PARAGRAPH) {
                        return SelectableText(
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
