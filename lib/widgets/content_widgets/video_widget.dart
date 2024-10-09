import 'package:dei_marc/config/text_styles.dart';
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

    final videoUrl =
        Provider.of<ConfigProvider>(context).getVideoPath(videoName!);

    if (videoUrl == null) {
      return const Center(child: Text('Video not found.'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: Colors.white70,
        child: InkWell(
          onTap: () => _launchURL(videoUrl, context),
          borderRadius: BorderRadius.circular(18.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  color: primaryColor,
                  size: 24.0,
                ),
                const SizedBox(width: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Watch Video',
                      style: TextStyles.appCaption.copyWith(
                        color: primaryColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Tap to play',
                      style: TextStyles.appCaption.copyWith(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: primaryColor,
                  size: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url, BuildContext context) async {
    if (url.isEmpty || url == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🚧 '),
              SizedBox(width: 8.0),
              Text(
                'Video not added yet',
                style: TextStyles.appCaption,
              ),
              SizedBox(width: 8.0),
              Text(' 🚧'),
            ],
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.grey[900],
        ),
      );
      return;
    }

    try {
      Uri parsedUrl = Uri.parse(url);
      if (!await launchUrl(parsedUrl, mode: LaunchMode.platformDefault)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
