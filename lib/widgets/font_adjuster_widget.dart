import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/settings_provider.dart';

class FontSizeAdjusterWidget extends StatelessWidget {
  final Color appBarColor;
  final Color secondaryColor;

  const FontSizeAdjusterWidget({
    Key? key,
    required this.appBarColor,
    required this.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          color: secondaryColor,
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
                    style: TextStyle(
                      fontSize: settingsProvider.fontSize,
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
            ],
          ),
        );
      },
    );
  }
}
