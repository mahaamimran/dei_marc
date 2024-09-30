import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:dei_marc/providers/config_provider.dart';
import 'package:dei_marc/utils/connection_util.dart';

class VideoWidget extends StatelessWidget {
  final String? videoName;

  const VideoWidget({
    super.key,
    required this.videoName,
  });

  @override
  Widget build(BuildContext context) {
    if (videoName == null) return const SizedBox.shrink();

    // Fetch the video link from config using videoName as the key
    final videoUrl = Provider.of<ConfigProvider>(context).getVideoPath(videoName!);

    if (videoUrl == null) {
      return const Text('Video not found.');
    }

    return FutureBuilder<bool>(
      future: ConnectionUtil().isConnected(), // Check internet connection
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the connection check is ongoing, show a loading indicator
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data == true) {
          // If connected, show a clickable link
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () => _launchURL(videoUrl),
              child: const Text(
                'Watch Video',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
        } else {
          return const Text('No internet connection.');
        }
      },
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
