// widgets/image_widget.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/providers/config_provider.dart';

class ImageWidget extends StatelessWidget {
  final String? imageName;

  const ImageWidget({
    super.key,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    if (imageName == null) return const SizedBox.shrink();

    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final imagePath = configProvider.getImagePath(imageName);

    if (imagePath != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.asset(
          AssetPaths.image(imagePath),
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('Error loading image: $error');
            return const Text('Image not found');
          },
        ),
      );
    } else {
      print('Image path is null for $imageName');
      return const Text('Image not found');
    }
  }
}
