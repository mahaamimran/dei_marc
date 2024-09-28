// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/screens/tab_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600), // Faster bounce effect
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.1), // Gentle bounce effect
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Navigate to the home screen after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      _navigateToHome();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 400), // Quicker fade transition
        pageBuilder: (context, animation, secondaryAnimation) =>
            const TabBarScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final opacityAnimation =
              Tween<double>(begin: 0.0, end: 1.0).animate(animation);
          return FadeTransition(opacity: opacityAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetPaths.launchScreenBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SlideTransition(
              position: _animation,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'GENDER\nDEI TOOLKITS',
                      textAlign: TextAlign.center,
                      style: TextStyles.appBarTitle.copyWith(
                        fontWeight: FontWeight.w700, // Bold font weight
                        fontSize: 28, // Larger font size for emphasis
                        color: Colors.white, // White color for contrast
                      ),
                    ),
                    const SizedBox(height: 8), // Space between the two lines
                    Text(
                      'By MARC',
                      textAlign: TextAlign.center,
                      style: TextStyles.appBarTitle.copyWith(
                        fontWeight:
                            FontWeight.w400, // Regular weight for subtitle
                        fontSize: 24, // Smaller font size for subtitle
                        letterSpacing: 1.0, // Slight letter spacing
                        color: Colors.white70, // Lighter shade of white
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
