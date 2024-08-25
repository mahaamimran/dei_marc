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
        title: Text(
          'Settings',
          style: TextStyles.appBarTitle(context).copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                  style: TextStyles.heading(context).copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Aa',
                      style: TextStyle(
                        fontSize: settingsProvider.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: settingsProvider.fontSize,
                        min: 14.0,
                        max: 24.0,
                        divisions: 10,
                        label: settingsProvider.fontSize.round().toString(),
                        onChanged: (double value) {
                          settingsProvider.setFontSize(value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SettingsOption(
                  title: 'Notifications',
                  onTap: () {
                  },
                ),
                SettingsOption(
                  title: 'Support',
                  onTap: () {
                  },
                ),
                SettingsOption(
                  title: 'About',
                  onTap: () {
                  },
                ),
                SettingsOption(
                  title: 'Privacy and Security',
                  onTap: () {
                  },
                ),
                SettingsOption(
                  title: 'Copyright',
                  onTap: () {
                  },
                ),
                SettingsOption(
                  title: 'Share App',
                  onTap: () {
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingsOption({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
          onTap: onTap,
        ),
        Divider(
          color: Colors.grey[300],
          thickness: 1.0,
        ),
      ],
    );
  }
}
