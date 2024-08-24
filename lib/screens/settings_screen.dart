import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFB52556),
                Color.fromARGB(255, 108, 160, 166),
              ],
            ),
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyles.appBarTitle
              .copyWith(color: const Color.fromARGB(255, 248, 246, 246)),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Font Size',
                  style: TextStyles.heading.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                  value: settingsProvider.fontSize,
                  min: 14.0,
                  max: 24.0,
                  divisions: 10,
                  label: settingsProvider.fontSize.round().toString(),
                  onChanged: (double value) {
                    settingsProvider.setFontSize(value);
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Aa',
                  style: TextStyle(
                    fontSize: settingsProvider.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
