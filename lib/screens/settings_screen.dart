import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Font size'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Logic to switch size
                if (value) {
                  // Set dark theme
                  // Implement your size switching logic here
                } else {
                  // Set light theme
                  // Implement your size switching logic here
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Notifications'),
            trailing: Switch(
              value: true, // Replace with actual notification setting value
              onChanged: (value) {
                // Logic to toggle notifications
                // Implement your notification toggling logic here
              },
            ),
          ),
          ListTile(
            title: const Text('About'),
            trailing: Switch(
              value: true, // Replace with about setting value
              onChanged: (value) {
                // Logic to display about
              },
            ),
          ),
          ListTile(
            title: const Text('Privacy and Security'),
            trailing: Switch(
              value: true, // Replace with actual privacy setting value
              onChanged: (value) {
                // Logic to display privacy and security
              },
            ),
          ),
          ListTile(
            title: const Text('Copyright'),
            trailing: Switch(
              value: true, // Replace with actual copyrights setting value
              onChanged: (value) {
                // Logic to display copyrights info
              },
            ),
          ),
          ListTile(
            title: const Text('Share App'),
            trailing: Switch(
              value: true, // Replace with actual share app setting value
              onChanged: (value) {
                // Logic to display share app URL
              },
            ),
          ),
        ],
      ),
    );
  }
}
