import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@healthapp.com',
      queryParameters: {
        'subject': 'Support Request - Health App',
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '0712345678');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out successfully")),
              );
              // TODO: Implement logout logic (Firebase/Auth etc.)
            },
            child: const Text("Log Out"),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Help & Support"),
        content: const Text(
          "If you encounter issues, please:\n\n"
          "1. Check the FAQ section in the app.\n"
          "2. Contact our support team via 'Contact Us'.\n"
          "3. Report bugs by sending us an email.\n\n"
          "We’ll respond as soon as possible!",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          // GENERAL SETTINGS
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              leading: const Icon(Icons.settings),
              title: const Text('General Settings'),
              subtitle: const Text('Notifications & Appearance'),
              children: [
                SwitchListTile(
                  title: const Text("Enable Notifications"),
                  value: _notificationsEnabled,
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text("Dark Mode"),
                  value: _darkModeEnabled,
                  onChanged: (val) {
                    setState(() {
                      _darkModeEnabled = val;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // HISTORY
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('History'),
            subtitle:
                const Text('All appointments, bookings, and emergencies'),
            trailing: const Icon(Icons.arrow_right),
            tileColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: () {
              // TODO: Navigate to History Page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Opening History...")),
              );
            },
          ),
          const SizedBox(height: 15),

          // CONTACT US
          ListTile(
            leading: const Icon(Icons.contact_emergency),
            title: const Text('Contact Us'),
            subtitle: const Text('Reach out for more info'),
            trailing: const Icon(Icons.arrow_right),
            tileColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: () async {
              await _launchEmail();
            },
            onLongPress: () async {
              await _launchPhone();
            },
          ),
          const SizedBox(height: 15),

          // HELP
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            subtitle: const Text('Report any bugs or problems'),
            trailing: const Icon(Icons.arrow_right),
            tileColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: _showHelpDialog,
          ),
          const SizedBox(height: 15),

          // LOG OUT
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out'),
            trailing: const Icon(Icons.arrow_right, color: Colors.red),
            tileColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: _showLogoutDialog,
          ),
        ],
      ),
    );
  }
}
