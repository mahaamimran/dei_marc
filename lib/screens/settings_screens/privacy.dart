import 'package:flutter/material.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          'Privacy Policy',
          style: TextStyles.appBarTitle.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "This application does not collect or store personal data.",
                style: TextStyles.content(context).copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              Text(
                "We are committed to respecting your privacy. This app does not collect, store, or share any personal data from its users, whether you are using Android or iOS devices.",
                style: TextStyles.content(context).copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              Text(
                "For Android users:",
                style: TextStyles.content(context).copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "If you downloaded this application from Google Play, please note that Google Play Services may collect some personal data as part of its standard app distribution. We recommend reviewing the Google Play privacy policy for more details:",
                style: TextStyles.content(context).copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => _launchURL('https://policies.google.com/privacy'),
                child: Text(
                  'Google Play Privacy Policy',
                  style: TextStyles.content(context).copyWith(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "For iOS users:",
                style: TextStyles.content(context).copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                "If you downloaded this application from the Apple App Store, no personal data is collected or stored by this app. However, Apple may collect some data as part of its app store services. We encourage you to review Apple's privacy policy for more information:",
                style: TextStyles.content(context).copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => _launchURL('https://www.apple.com/legal/privacy/'),
                child: Text(
                  'Apple Privacy Policy',
                  style: TextStyles.content(context).copyWith(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
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
