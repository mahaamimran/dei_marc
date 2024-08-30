import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Settings',
          style: TextStyles.appBarTitle.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        border: null,
      ),
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildFontSizeSection(settingsProvider),
                const SizedBox(height: 20),
                _buildFontPreview(settingsProvider),
                const SizedBox(height: 20),
                _buildFontFamilySection(settingsProvider, context),
                const Divider(height: 40, thickness: 2),
                ..._buildSettingsOptions(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFontSizeSection(SettingsProvider settingsProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Font Size',
          style: TextStyles.appTitle,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), 
          child: Slider(
            value: settingsProvider.fontSize,
            min: 14.0,
            max: 24.0,
            divisions: 10,
            activeColor: CupertinoColors.black,
            thumbColor: CupertinoColors.black,
            onChanged: (double value) {
              settingsProvider.setFontSize(value);
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            settingsProvider.fontSize.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFontPreview(SettingsProvider settingsProvider) {
    return Center(
      child: Text(
        'DEI MARC',
        style: TextStyle(
          fontFamily: settingsProvider.fontFamily,
          fontSize: settingsProvider.fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildFontFamilySection(SettingsProvider settingsProvider,
      BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Font Family',
          style: TextStyles.appTitle,
        ),
        const SizedBox(height: 10),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            _showFontFamilyPicker(context, settingsProvider);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  settingsProvider.fontFamily,
                  style: TextStyle(
                    fontFamily: settingsProvider.fontFamily,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const Icon(
                  CupertinoIcons.chevron_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showFontFamilyPicker(
      BuildContext context, SettingsProvider settingsProvider) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.white,
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) {
              const fontOptions = ['Raleway', 'Roboto', 'Arial'];
              settingsProvider.setFontFamily(fontOptions[index]);
            },
            children: const [
              Text('Raleway', style: TextStyle(fontFamily: 'Raleway')),
              Text('Roboto', style: TextStyle(fontFamily: 'Roboto')),
              Text('Arial', style: TextStyle(fontFamily: 'Arial')),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildSettingsOptions() {
    final options = [
      'Notifications',
      'Support',
      'About',
      'Privacy and Security',
      'Copyright',
      'Share App',
    ];

    return options.map((option) {
      return SettingsOption(
        title: option,
        onTap: () {
          // Handle option tap here
        },
      );
    }).toList();
  }
}

class SettingsOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingsOption({super.key, 
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyles.appCaption.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const Icon(
                CupertinoIcons.forward,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey[300],
          thickness: 1.0,
        ),
      ],
    );
  }
}
