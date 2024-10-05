// import 'package:dei_marc/providers/settings_provider.dart';
// import 'package:dei_marc/screens/tab_bar_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:dei_marc/config/color_constants.dart';
// import 'package:dei_marc/config/text_styles.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         // Full-screen gradient background
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFFFFFFFF), // White at the top
//               Color(0xFFD4D4D4), // Light grey at the bottom
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           // Apply SafeArea only to the content
//           top: true, // Avoid SafeArea for the top
//           bottom: false, // Avoid SafeArea for the bottom
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 17),
//                   Image.asset(
//                     'assets/app_logo/DEI.png',
//                     height: screenHeight * 0.12,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Welcome to Gender DEI Toolkit',
//                     style: TextStyles.appBarTitle.copyWith(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'A guide to build a more inclusive workplace. Understand the gender spectrum, and learn how to create an environment where everyone can thrive.',
//                     style: TextStyles.appCaption.copyWith(fontSize: 14, color: Colors.grey[800]),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'What you\'ll learn',
//                     style: TextStyles.appCaption.copyWith(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   GridView.count(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     childAspectRatio: 1.2, // Adjust for better card fit
//                     children: const [
//                       OnboardingCard(
//                         title: 'Learning Outcome 1',
//                         subtitle: 'Description of learning outcome 1',
//                       ),
//                       OnboardingCard(
//                         title: 'Learning Outcome 2',
//                         subtitle: 'Description of learning outcome 2',
//                       ),
//                       OnboardingCard(
//                         title: 'Learning Outcome 3',
//                         subtitle: 'Description of learning outcome 3',
//                       ),
//                       OnboardingCard(
//                         title: 'Learning Outcome 4',
//                         subtitle: 'Description of learning outcome 4',
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),

//                   // "Get Started" button redesigned with non-repeating colors
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       gradient: LinearGradient(
//                         colors: [
//                           ColorConstants.booksPrimary[0],
//                           ColorConstants.booksPrimary[2],
//                           ColorConstants.booksPrimary[1],
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                     ),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: () async {
//                         final settingsProvider = Provider.of<SettingsProvider>(
//                             context,
//                             listen: false);
//                         await settingsProvider.setHasSeenOnboarding(true);
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const TabBarScreen()),
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 15.0),
//                         child: Text(
//                           'Get Started',
//                           style: TextStyles.appTitle.copyWith(
//                             fontSize: 18,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class OnboardingCard extends StatelessWidget {
//   final String title;
//   final String subtitle;

//   const OnboardingCard(
//       {super.key, required this.title, required this.subtitle});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0), // Adjusted padding for better fit
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyles.appCaption.copyWith(
//                 fontSize: 16, // Increased font size for better readability
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               subtitle,
//               style: TextStyles.appCaption.copyWith(
//                 fontSize: 14,
//                 color: Colors.grey[800],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
