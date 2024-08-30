import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';

class FontSettingsWidget extends StatelessWidget {
  final Color appBarColor;
  final Color secondaryColor;

  const FontSettingsWidget({
    super.key,
    required this.appBarColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Adjust Font Size',
                style: TextStyle(
                  color: appBarColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      double newSize = settingsProvider.fontSize - 2;
                      if (newSize >= 14.0) {
                        settingsProvider.setFontSize(newSize);
                      }
                    },
                  ),
                  Text(
                    settingsProvider.fontSize.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      double newSize = settingsProvider.fontSize + 2;
                      if (newSize <= 24.0) {
                        settingsProvider.setFontSize(newSize);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'Select Font Family',
                style: TextStyle(
                  color: appBarColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 150.0, // Adjust the height to your needs
                child: ListView(
                  children: [
                    _buildFontOption('Raleway', settingsProvider),
                    _buildFontOption('Roboto', settingsProvider),
                    _buildFontOption('Arial', settingsProvider),
                    // Add more font options if needed
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFontOption(String fontName, SettingsProvider settingsProvider) {
    return ListTile(
      title: Text(
        fontName,
        style: TextStyle(fontFamily: fontName),
      ),
      trailing: settingsProvider.fontFamily == fontName
          ? Icon(Icons.check, color: appBarColor)
          : null,
      onTap: () {
        settingsProvider.setFontFamily(fontName);
      },
    );
  }
}
