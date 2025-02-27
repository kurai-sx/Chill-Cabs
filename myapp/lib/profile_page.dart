import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_page_options.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // ✅ Updates profile image
      });
    }
  }

  void _showImagePicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick an image'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _pickImage(ImageSource.camera); // ✅ Open Camera
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _pickImage(ImageSource.gallery); // ✅ Open Gallery
            },
            child: Text('Gallery'),
          ),
        ],
      ),
    );
  }

  void _logout() {
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
                    (Route<dynamic> route) => false, // ✅ Clears all routes
              );
            },
            child: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
                  Stack(
                    alignment: Alignment.bottomRight, // ✅ Aligns edit button correctly
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!) // ✅ Shows selected image
                            : AssetImage('images/profileimage.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _showImagePicker, // ✅ Open picker dialog
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(Icons.edit, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
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
              onTap: _logout,
            ),
          ],
        ),
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
