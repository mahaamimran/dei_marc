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
      duration: const Duration(seconds: 2), // Smoother and slower animation
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.1), // Gentle bounce effect
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Navigate to the home screen after the splash screen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const TabBarScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Gender DEI Toolkits',
                    textAlign: TextAlign.center,
                    style: TextStyles.appBarTitle.copyWith(
                      fontWeight: FontWeight.w700, // Bold font weight
                      fontSize: 30, // Larger font size for emphasis
                      letterSpacing: 1.5, // Slightly more letter spacing
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
    );
  }
}
