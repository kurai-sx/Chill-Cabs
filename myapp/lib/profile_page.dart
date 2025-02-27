import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import the theme provider
import 'language_provider.dart'; // Import the language provider
import 'profile_page_options.dart'; // Import the settings page

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('images/profileimage.png'),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Suraj Nagre',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'surajnagre@gmail.com',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            buildProfileOption(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()), // ✅ Navigate correctly
              ),
            ),

            buildProfileOption(
              icon: Icons.privacy_tip,
              title: 'Privacy',
              onTap: () => Navigator.pushNamed(context, '/privacy'),
            ),
            buildProfileOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => Navigator.pushNamed(context, '/help'),
            ),
            buildProfileOption(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil(
                "/mobile_auth",
                    (Route<dynamic> route) => false, // Clears all previous routes
              );
            },
            child: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget buildProfileOption({required IconData icon, required String title, required Function() onTap}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, size: 30.0, color: Colors.amber),
        title: Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
