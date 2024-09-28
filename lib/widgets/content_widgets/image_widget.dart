import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/providers/config_provider.dart';

class ImageWidget extends StatefulWidget {
  final String? imageName;

  const ImageWidget({
    super.key,
    required this.imageName,
  });

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget>
    with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  late AnimationController _animationController;
  Animation<Matrix4>? _animationReset;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animationController.addListener(() {
      _transformationController.value = _animationReset!.value;
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onInteractionEnd() {
    // Animate the image back to its original size and position (Matrix4.identity())
    _animationReset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageName == null) return const SizedBox.shrink();

    final configProvider = Provider.of<ConfigProvider>(context, listen: false);
    final imagePath = configProvider.getImagePath(widget.imageName);

    if (imagePath != null) {
      return GestureDetector(
        onDoubleTap: () {
          _transformationController.value = Matrix4.identity();
        },
        onScaleEnd: (_) => _onInteractionEnd(), // Snap back on release
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InteractiveViewer(
            transformationController: _transformationController,
            panEnabled: true, // Allow panning
            scaleEnabled: true, // Enable zoom on touch
            boundaryMargin: EdgeInsets.zero, // Keep within boundaries
            minScale: 1.0, // No zoom out smaller than original
            maxScale: 4.0, // Set maximum zoom level
            //clipBehavior: Clip.none, // Prevent clipping during zoom
            onInteractionEnd: (_) => _onInteractionEnd(), // Snap back when released
            child: Image.asset(
              AssetPaths.image(imagePath),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $error');
                return const Text('Image not found');
              },
            ),
          ),
        ),
      );
    } else {
      print('Image path is null for ${widget.imageName}');
      return const Text('Image not found');
    }
  }
}
