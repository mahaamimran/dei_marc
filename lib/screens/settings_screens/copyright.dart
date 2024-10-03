import 'dart:convert';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/constants.dart';
import 'package:dei_marc/models/content_item.dart';
import 'package:dei_marc/widgets/content_widgets/bullet_widget.dart';
import 'package:dei_marc/widgets/content_widgets/description_widget.dart';
import 'package:dei_marc/widgets/content_widgets/heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class CopyrightScreen extends StatefulWidget {
  const CopyrightScreen({super.key});

  @override
  _CopyrightScreenState createState() => _CopyrightScreenState();
}

class _CopyrightScreenState extends State<CopyrightScreen> {
  List<ContentItem> disclaimerContents = [];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    final String response = await rootBundle.loadString(AssetPaths.copyrightContentPath); 
    final data = json.decode(response);
    var contentList = data['content'] as List;
    setState(() {
      disclaimerContents = contentList.map((item) => ContentItem.fromJson(item)).toList();
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
          'Copyright',
          style: TextStyles.appBarTitle.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return Scrollbar(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: disclaimerContents.map((disclaimerContent) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Text(
                      disclaimerContent.heading!,
                      style: TextStyles.heading(context).copyWith(fontSize: 16),
                    ),
                    ...disclaimerContent.content.map((content) {
                      if (content.type == Constants.PARAGRAPH) {
                        return Text(
                          content.text,
                          style: TextStyles.content(context).copyWith(fontSize: 16),
                        );
                      } else if (content.type == Constants.BULLET) {
                        return Text(
                          "- ${content.text}",
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
