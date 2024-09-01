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
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          final fontOptions = ['Raleway', 'Roboto', 'Lexend'];
          final initialFontIndex = fontOptions.indexOf(settingsProvider.fontFamily);

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
                      icon: Icon(
                        Icons.remove,
                        color: settingsProvider.fontSize <= 11.0
                            ? Colors.grey.shade300
                            : Colors.black,
                      ),
                      onPressed: settingsProvider.fontSize <= 11.0
                          ? null
                          : () {
                              settingsProvider.setFontSize(
                                  settingsProvider.fontSize - 2);
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
                      icon: Icon(
                        Icons.add,
                        color: settingsProvider.fontSize >= 32.0
                            ? Colors.grey.shade300
                            : Colors.black,
                      ),
                      onPressed: settingsProvider.fontSize >= 32.0
                          ? null
                          : () {
                              settingsProvider.setFontSize(
                                  settingsProvider.fontSize + 2);
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
                    scrollController: FixedExtentScrollController(
                        initialItem: initialFontIndex),
                    onSelectedItemChanged: (int index) {
                      settingsProvider.setFontFamily(fontOptions[index]);
                    },
                    children: fontOptions.map((font) {
                      return Text(font, style: TextStyle(fontFamily: font));
                    }).toList(),
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
