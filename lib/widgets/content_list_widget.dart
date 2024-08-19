import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/models/content_item.dart';
import 'package:dei_marc/models/quote.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/config_provider.dart';

class ContentImageWidget extends StatelessWidget {
  final String? imageName;

  const ContentImageWidget({Key? key, this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageName == null) return SizedBox.shrink();

    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final imagePath = configProvider.getImagePath(imageName!);

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
}

class ContentItemWidget extends StatelessWidget {
  final ContentItem contentItem;

  const ContentItemWidget({Key? key, required this.contentItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contentItem.content.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contentItem.content.map((quote) {
        if (quote.type == 'subheading') {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  quote.text,
                  style: TextStyles.subheading.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...?quote.content?.map((nestedQuote) {
                return _buildQuote(nestedQuote);
              }).toList(),
            ],
          );
        } else {
          return _buildQuote(quote);
        }
      }).toList(),
    );
  }

  Widget _buildQuote(Quote quote) {
    switch (quote.type) {
      case 'image':
        return ContentImageWidget(imageName: quote.text);
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
      case 'subheading':
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            quote.text,
            style: TextStyles.subheading.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
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
  }
}
