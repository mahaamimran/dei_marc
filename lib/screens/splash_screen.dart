import 'dart:async';
import 'package:dei_marc/config/asset_paths.dart';
import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';
// import 'package:dei_marc/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:dei_marc/screens/tab_bar_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      // _checkOnboarding();
      _navigateToHome();
    });
  }

  // void _checkOnboarding() async {
  //   final settingsProvider =
  //       Provider.of<SettingsProvider>(context, listen: false);
  //   if (settingsProvider.hasSeenOnboarding) {
  //     _navigateToHome();
  //   } else {
  //     _navigateToHome();
  //     // _navigateToOnboarding();
  //   }
  // }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // void _navigateToOnboarding() {
  //   Navigator.of(context).pushReplacement(
  //     PageRouteBuilder(
  //       transitionDuration: const Duration(milliseconds: 400),
  //       pageBuilder: (context, animation, secondaryAnimation) =>
  //           const OnboardingScreen(),
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //         final opacityAnimation =
  //             Tween<double>(begin: 0.0, end: 1.0).animate(animation);
  //         return FadeTransition(opacity: opacityAnimation, child: child);
  //       },
  //     ),
  //   );
  // }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
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
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _pulseAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'GENDER\nDEI TOOLKITS',
                          textAlign: TextAlign.center,
                          style: TextStyles.appBarTitle.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              color: Colors.white,
                              letterSpacing: 1.5,
                              height: 1.2),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'BY MARC',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          letterSpacing: 10,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
