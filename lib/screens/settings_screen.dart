// ignore_for_file: prefer_const_declarations

import 'package:dei_marc/config/constants.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyles.appBarTitle.copyWith(color: Colors.black),
          ),
          backgroundColor: Colors.grey[200],
        ),
        body: SafeArea(
          child: Consumer<SettingsProvider>(
            builder: (context, settingsProvider, child) {
              return Scrollbar(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildSectionTitle('General'),
                    const SizedBox(height: 10),
                    _buildSettingsOption('Notifications', CupertinoIcons.bell,
                        () {
                      // Handle Notifications tap
                    }),
                    _buildSettingsOption(
                        'Privacy and Security', CupertinoIcons.lock, () {
                      // Handle Privacy and Security tap
                    }),
                    _buildSettingsOption(
                        'Support', CupertinoIcons.question_circle, () {
                      // Handle Support tap
                    }),
                    const Divider(height: 40, thickness: 2),
                    _buildSectionTitle('Font Settings'),
                    const SizedBox(height: 10),
                    _buildPreviewText(settingsProvider),
                    const SizedBox(height: 10),
                    _buildFontSizeSection(settingsProvider),
                    const SizedBox(height: 20),
                    _buildFontFamilySection(settingsProvider, context),
                    const Divider(height: 40, thickness: 2),
                    _buildSectionTitle('About'),
                    const SizedBox(height: 10),
                    _buildSettingsOption('About', CupertinoIcons.info, () {
                      // Handle About tap
                    }),
                    _buildSettingsOption('Copyright', CupertinoIcons.circle,
                        () {
                      // Handle Copyright tap
                    }),
                    _buildSettingsOption('Share App', CupertinoIcons.share, () {
                      // Handle Share App tap
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewText(SettingsProvider settingsProvider) {
    return Center(
      child: Text(
        'DEI MARC',
        style: TextStyle(
          fontFamily: settingsProvider.fontFamily,
          fontSize: settingsProvider.fontSize,
          color: Colors.black,
        ),
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

  Widget _buildSettingsOption(String title, IconData icon, VoidCallback onTap) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyles.appCaption.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Icon(
            CupertinoIcons.forward,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildFontSizeSection(SettingsProvider settingsProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Font Size',
          style: TextStyles.appCaption.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CupertinoSlider(
                value: settingsProvider.fontSize,
                min: Constants.FONT_SIZE_MIN,
                max: Constants.FONT_SIZE_MAX,
                activeColor: CupertinoColors.black,
                thumbColor: CupertinoColors.black,
                onChanged: (double value) {
                  settingsProvider.setFontSize(value);
                },
              ),
            ),
            const SizedBox(width: 10),
            Text(
              settingsProvider.fontSize
                  .toInt()
                  .toString(), // Display as integer
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFontFamilySection(
      SettingsProvider settingsProvider, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Font Family',
          style: TextStyles.appCaption.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
    final fontOptions = Constants.FONT_FAMILIES;
    final initialFontIndex = fontOptions.indexOf(settingsProvider.fontFamily);

    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          color: Colors.white,
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 32.0,
            scrollController: FixedExtentScrollController(
              initialItem: initialFontIndex,
            ),
            onSelectedItemChanged: (int index) {
              settingsProvider.setFontFamily(fontOptions[index]);
            },
            children: fontOptions.map((font) {
              return Text(font, style: TextStyle(fontFamily: font));
            }).toList(),
          ),
        );
      },
    );
  }
}
