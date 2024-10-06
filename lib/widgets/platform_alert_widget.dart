import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dei_marc/config/text_styles.dart';

class PlatformAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<PlatformAlertOption> options;

  const PlatformAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: _buildCupertinoActions(context),
      );
    } else {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyles.appTitle,
        ),
        content: Text(content, style: TextStyles.appCaption.copyWith(color: Colors.grey[800])),
        actions: _buildMaterialActions(context),
      );
    }
  }

  List<Widget> _buildCupertinoActions(BuildContext context) {
    return options.map((option) {
      return CupertinoDialogAction(
        isDestructiveAction: option.isCancel,
        onPressed: () {
          Navigator.of(context).pop();
          option.onPressed();
        },
        child: Text(
          option.label,
          style: TextStyle(
            color: option.isCancel
                ? CupertinoColors.systemRed
                : option.useDefaultColor
                    ? null // Use default iOS color for non-cancel buttons
                    : CupertinoColors.black,
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildMaterialActions(BuildContext context) {
    return options.map((option) {
      return TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          option.onPressed();
        },
        style: TextButton.styleFrom(
          foregroundColor: option.isCancel
              ? Colors.red
              : option.useDefaultColor
                  ? Theme.of(context).primaryColor // Use platform default for material
                  : Colors.black,
        ),
        child: Text(option.label, style: TextStyles.appCaption.copyWith(color: option.isCancel ? Colors.red : Colors.black)),
      );
    }).toList();
  }
}

class PlatformAlertOption {
  final String label;
  final VoidCallback onPressed;
  final bool isCancel;
  final bool useDefaultColor;

  PlatformAlertOption({
    required this.label,
    required this.onPressed,
    this.isCancel = false,
    this.useDefaultColor = false,
  });
}
