import 'package:dei_marc/config/text_styles.dart';
import 'package:dei_marc/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFB52556),
                Color.fromARGB(255, 108, 160, 166),
              ],
            ),
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyles.appBarTitle
              .copyWith(color: const Color.fromARGB(255, 248, 246, 246)),
        ),
        backgroundColor: Colors.transparent,
      ),
        body: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) {
            return ListView(
              padding: const EdgeInsets.all(
                  8.0), // Padding around the entire ListView
              children: [
                _buildFontSizeTile(context, settingsProvider),
                //_buildNotificationsTile(context, settingsProvider),
                _buildNavigationTile(
                  context,
                  title: 'Privacy Policy',
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Navigate to privacy policy screen or display modal
                  },
                ),
                _buildNavigationTile(
                  context,
                  title: 'Copyrights',
                  icon: Icons.arrow_forward_ios,
                  onTap: () {
                    // Navigate to copyrights screen or display modal
                  },
                ),
                _buildNavigationTile(
                  context,
                  title: 'Share App',
                  icon: Icons.share,
                  onTap: () {
                    // Implement sharing functionality
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFontSizeTile(
      BuildContext context, SettingsProvider settingsProvider) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 4.0), // Padding between tiles
      child: ListTile(
        tileColor: Colors.grey[200], // Light grey background color for the tile
        title: const Text('Font size'),
        trailing: DropdownButton<double>(
          value: settingsProvider.fontSize,
          items: [14.0, 16.0, 18.0, 20.0].map((double value) {
            return DropdownMenuItem<double>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              settingsProvider.setFontSize(value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildNavigationTile(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 4.0), // Padding between tiles
      child: ListTile(
        tileColor: Colors.grey[200], // Light grey background color for the tile
        title: Text(title),
        trailing: Icon(icon),
        onTap: onTap,
      ),
    );
  }
}
