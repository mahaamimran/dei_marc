import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/config_provider.dart';

class VideoWidget extends StatelessWidget {
  final String? videoName;
  final Color primaryColor;

  const VideoWidget({
    super.key,
    required this.videoName,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    if (videoName == null) return const SizedBox.shrink();

    // Fetch the video link from config using videoName as the key
    final videoUrl = Provider.of<ConfigProvider>(context).getVideoPath(videoName!);

    if (videoUrl == null) {
      return const Center(child: Text('Video not found.'));
    }

    // Minimalistic custom layout
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Smaller padding
      child: Card(
        elevation: 2.0, // Lower elevation for a flatter design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0), // Rounded corners
        ),
        child: InkWell(
          onTap: () => _launchURL(videoUrl),
          borderRadius: BorderRadius.circular(18.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Minimal padding inside the card
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  color: primaryColor,
                  size: 24.0, // Small play icon
                ),
                const SizedBox(width: 12.0), // Space between icon and text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Watch Video',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold, // Thicker font weight
                        fontSize: 14.0, // Text size
                      ),
                    ),
                    Text(
                      'Tap to play',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0, // Smaller subtitle text size
                      ),
                    ),
                  ],
                ),
                const Spacer(), // Space between text and trailing icon
                Icon(
                  Icons.chevron_right,
                  color: primaryColor,
                  size: 24.0, // Smaller trailing icon
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
