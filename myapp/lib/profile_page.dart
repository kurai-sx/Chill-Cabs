import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage; // Variable to hold the selected image
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  // Function to pick an image from camera or gallery
  Future<void> _pickImage() async {
    // Show dialog to choose between camera and gallery
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick an image'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            child: Text('Gallery'),
          ),
        ],
      ),
    );

    // If the user selected a source
    if (source != null) {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path); // Set selected image
        });
      }
    }
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
            // Profile Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Profile image with edit button
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!) // Show selected image
                            : AssetImage('images/profileimage.png')
                        as ImageProvider, // Default profile image
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage, // Open camera or gallery
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  // User Name
                  Text(
                    'Suraj Nagre', // Replace with dynamic user name
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  // User Email
                  Text(
                    'surajnagre@gmail.com', // Replace with dynamic email
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            // Profile Options
            buildProfileOption(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                // Navigate to Settings Page
              },
            ),
            buildProfileOption(
              icon: Icons.privacy_tip,
              title: 'Privacy',
              onTap: () {
                // Navigate to Privacy Page
              },
            ),
            buildProfileOption(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {
                // Navigate to Help & Support Page
              },
            ),
            buildProfileOption(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                // Perform Logout action
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build profile option cards
  Widget buildProfileOption({required IconData icon, required String title, required Function() onTap}) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ListTile(
        leading: Icon(
          icon,
          size: 30.0,
          color: Colors.amber,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.transparent),
        onTap: onTap, // Action on tap
      ),
    );
  }
}
