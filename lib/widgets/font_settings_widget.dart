import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/config/text_styles.dart';
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Consumer<SettingsProvider>(
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
                  style: TextStyles.appTitle.copyWith(
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
                        if (newSize >= 10.0) {  // Adjusted the lower bound
                          settingsProvider.setFontSize(newSize);
                        }
                      },
                    ),
                    Text(
                      settingsProvider.fontSize.toInt().toString(),
                      style: TextStyles.appTitle.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        double newSize = settingsProvider.fontSize + 2;
                        if (newSize <= 32.0) {  // Adjusted the upper bound
                          settingsProvider.setFontSize(newSize);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Select Font Family',
                  style: TextStyles.appTitle.copyWith(
                    color: appBarColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 150.0,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 32.0,
                    onSelectedItemChanged: (int index) {
                      const fontOptions = ['Raleway', 'Roboto', 'Lexend'];
                      settingsProvider.setFontFamily(fontOptions[index]);
                    },
                    children: const [
                      Text('Raleway', style: TextStyle(fontFamily: 'Raleway')),
                      Text('Roboto', style: TextStyle(fontFamily: 'Roboto')),
                      Text('Lexend', style: TextStyle(fontFamily: 'Lexend')),
                    ],
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
