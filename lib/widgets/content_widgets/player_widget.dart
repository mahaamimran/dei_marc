// widgets/player_widget.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dei_marc/utils/connection_util.dart';

class PlayerWidget extends StatelessWidget {
  final String? videoUrl;

  const PlayerWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (videoUrl == null) return const SizedBox.shrink();

    final videoId = YoutubePlayer.convertUrlToId(videoUrl!);
    if (videoId == null) return const Text('Invalid video URL');

    return FutureBuilder<bool>(
      future: ConnectionUtil().isConnected(), // Check internet connection
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the connection check is ongoing, show a loading indicator
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data == true) {
          // If connected, show the embedded video
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                  controlsVisibleAtStart: true,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Theme.of(context).primaryColor,
            ),
          );
        } else {
          // If not connected, show a clickable link
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () => _launchURL(videoUrl!),
              child: const Text(
                'No internet connection. Click here to watch the video.',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
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
