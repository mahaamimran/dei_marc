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
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          final fontOptions = ['Raleway', 'Roboto', 'Lexend'];
          final initialFontIndex =
              fontOptions.indexOf(settingsProvider.fontFamily);

          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Adjust Font Size',
                    style: TextStyles.appTitle.copyWith(
                      color: appBarColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Flex(
                    direction: Axis.horizontal,
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
                                settingsProvider
                                    .setFontSize(settingsProvider.fontSize - 2);
                              },
                      ),
                      Flexible(
                        child: Center(
                          child: Text(
                            settingsProvider.fontSize.toInt().toString(),
                            style: TextStyles.appTitle.copyWith(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
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
                                settingsProvider
                                    .setFontSize(settingsProvider.fontSize + 2);
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
                    height: 100.0,
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
            ),
          );
        },
      ),
    );
  }
}
