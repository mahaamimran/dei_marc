// widgets/content_items.dart

import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/models/content_item.dart';
import 'package:dei_marc/providers/config_provider.dart';
import 'package:provider/provider.dart';

class ContentListWidget extends StatelessWidget {
  final ContentItem contentItem;

  const ContentListWidget({Key? key, required this.contentItem}) : super(key: key);

  Widget _buildImage(BuildContext context, String? imageName) {
    if (imageName == null) return SizedBox.shrink();

    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final imagePath = configProvider.getImagePath(imageName);

    if (imagePath != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.asset(
          'assets/$imagePath',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Text('Image not found');
          },
        ),
      );
    } else {
      return Text('Image not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (contentItem.content.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contentItem.content.map((quote) {
        switch (quote.type) {
          case 'image':
            return _buildImage(context, quote.text);
          case 'bullet':
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• "),
                  Expanded(
                    child: Text(
                      quote.text,
                      style: TextStyles.caption.copyWith(
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            );
          case 'subheading':
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                quote.text,
                style: TextStyles.title.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          case 'paragraph':
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                quote.text,
                style: TextStyles.caption.copyWith(
                  color: Colors.grey[800],
                ),
              ),
            );
          case 'video':
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'Video content is currently not supported',
                style: TextStyles.caption.copyWith(
                  color: Colors.grey[800],
                ),
              ),
            );
          default:
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                quote.text,
                style: TextStyles.caption.copyWith(
                  color: Colors.grey[800],
                ),
              ),
            );
        }
      }).toList(),
    );
  }
}
