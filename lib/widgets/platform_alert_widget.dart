import 'package:dei_marc/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PlatformAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onClear;

  const PlatformAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              onClear();
              Navigator.of(context).pop();
            },
            child: const Text("Clear",
                style: TextStyle(color: CupertinoColors.systemRed)),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyles.appTitle,
        ),
        content: Text(content, style: TextStyles.appCaption.copyWith(color: Colors.grey[800])),
        actions: [
          TextButton(
            child: Text(
              "Cancel",
              style: TextStyles.appCaption.copyWith(color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: () {
              onClear();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text("Clear", style: TextStyles.appCaption.copyWith(color: Colors.red),),
          ),
        ],
      );
    }
  }
}
