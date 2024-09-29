// import 'package:dei_marc/screens/pdf_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// class CustomFloatingActionButton extends StatelessWidget {
//   final Color appBarColor;

//   const CustomFloatingActionButton({
//     Key? key,
//     required this.appBarColor,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SpeedDial(
//       animatedIcon: AnimatedIcons.menu_close,
//       backgroundColor: appBarColor,
//       foregroundColor: Colors.white,
//       children: [
//         SpeedDialChild(
//           shape: const CircleBorder(),
//           label: 'Module',
//           child: const Icon(
//             Icons.picture_as_pdf_rounded,
//             size: 23,
//             color: Colors.white,
//           ),
//           backgroundColor: appBarColor,
//           onTap: () => _openPDF(context, 'Module PDF URL'),
//         ),
//         SpeedDialChild(
//           shape: const CircleBorder(),
//           label: 'Activity 1',
//           child: const Icon(
//             Icons.picture_as_pdf_rounded,
//             size: 23,
//             color: Colors.white,
//           ),
//           backgroundColor: appBarColor,
//           onTap: () => _openPDF(context, 'Activity 1 PDF URL'),
//         ),
//         SpeedDialChild(
//           shape: const CircleBorder(),
//           label: 'Activity 2',
//           child: const Icon(
//             Icons.picture_as_pdf_rounded,
//             size: 23,
//             color: Colors.white,
//           ),
//           backgroundColor: appBarColor,
//           onTap: () => _openPDF(context, 'Activity 2 PDF URL'),
//         ),
//       ],
//     );
//   }

//   void _openPDF(BuildContext context, String pdfUrl) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PDFScreen(
//           appBarColor: appBarColor,
//           pdfUrl: pdfUrl,
//         ),
//       ),
//     );
//   }
// }
