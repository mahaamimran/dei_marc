// ignore_for_file: prefer_const_declarations

import 'dart:io';

import 'package:dei_marc/config/constants.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:dei_marc/screens/settings_screens/about.dart';
import 'package:dei_marc/screens/settings_screens/copyright.dart';
import 'package:dei_marc/screens/settings_screens/privacy.dart';
import 'package:dei_marc/screens/settings_screens/support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
          centerTitle: true,
          scrolledUnderElevation: 0,
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
                    _buildSettingsOption('About', CupertinoIcons.info, () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AboutScreen(),
                        ),
                      );
                    }),
                    _buildSettingsOption('Copyright', Icons.copyright, () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CopyrightScreen(),
                        ),
                      );
                    }),
                    _buildSettingsOption(
                        'Privacy and Security', CupertinoIcons.lock, () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    }),
                    _buildSettingsOption(
                        'Support', CupertinoIcons.question_circle, () {
                      // Handle Support tap
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SupportScreen(),
                        ),
                      );
                    }),
                    // _buildSettingsOption('Share App', CupertinoIcons.share, () {
                    //   // Handle Share App tap
                    // }),
                    const Divider(height: 40, thickness: 2),
                    _buildSectionTitle('Font Settings'),
                    const SizedBox(height: 10),
                    _buildPreviewText(settingsProvider),
                    const SizedBox(height: 10),
                    _buildFontSizeSection(settingsProvider),
                    const SizedBox(height: 20),
                    _buildFontFamilySection(settingsProvider, context),
                    const Divider(height: 40, thickness: 2),
                   _buildClearCacheOption(context),
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
        'DEI Toolkits',
        style: TextStyle(
          fontFamily: settingsProvider.fontFamily,
          fontSize: settingsProvider.fontSize + 2,
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

  Widget _buildClearCacheOption(BuildContext context) {
    return TextButton(
      onPressed: () => _clearCacheAndShowSize(context),
      child: Text(
        'Clear Cache',
        style: TextStyles.appCaption.copyWith(color: Colors.red),
      ),
    );
  }

  Future<void> _clearCacheAndShowSize(BuildContext context) async {
    final cacheSize = await _getCacheSize();
    await _clearCache();
    _showCacheClearedAsText(context, cacheSize);
  }

  void _showCacheClearedAsText(BuildContext context, double totalSize) {
    final sizeInMB = totalSize.toStringAsFixed(2);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("You have cleared $sizeInMB MB of cache."),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<double> _getCacheSize() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      if (await cacheDir.exists()) {
        final files = cacheDir.listSync(recursive: true);
        double totalSize = 0;

        for (var file in files) {
          if (file is File) {
            totalSize += await file.length();
          }
        }
        return totalSize / (1024 * 1024); // Return size in MB
      }
      return 0; // If the directory doesn't exist, return 0
    } catch (e) {
      print('Error calculating cache size: $e');
      return 0;
    }
  }

  Future<void> _clearCache() async {
    try {
      final cacheDir = await getApplicationDocumentsDirectory();
      if (await cacheDir.exists()) {
        final files = cacheDir.listSync(recursive: true);

        for (var file in files) {
          if (file is File) {
            file.deleteSync();
          }
        }
      }
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }
}
