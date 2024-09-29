import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dei_marc/providers/config_provider.dart';
import 'package:dei_marc/utils/connection_util.dart';

class VideoWidget extends StatefulWidget {
  final String? videoName;

  const VideoWidget({
    super.key,
    required this.videoName,
  });

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    // Fetch the video URL from the config provider
    final videoUrl = Provider.of<ConfigProvider>(context, listen: false).getVideoPath(widget.videoName!);

    if (videoUrl != null) {
      // Extract YouTube video ID from the video URL
      final videoId = YoutubePlayer.convertUrlToId(videoUrl);
      if (videoId != null) {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            controlsVisibleAtStart: true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoName == null) return const SizedBox.shrink();

    // Fetch the video link from config using videoName as the key
    final videoUrl = Provider.of<ConfigProvider>(context).getVideoPath(widget.videoName!);

    if (videoUrl == null) {
      return const Text('Video not found.');
    }

    return FutureBuilder<bool>(
      future: ConnectionUtil().isConnected(), // Check internet connection
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator
        } else if (snapshot.hasData && snapshot.data == true) {
          // If connected, show the embedded YouTube video
          if (_controller != null) {
            return YoutubePlayer(
              controller: _controller!,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Theme.of(context).primaryColor,
            );
          } else {
            return const Text('No Video Found');
          }
        } else {
          // If no internet connection, show a clickable link
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: GestureDetector(
              onTap: () => _launchURL(videoUrl),
              child: const Text(
                'Click here to watch video',
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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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
