import 'package:flutter/foundation.dart';

import 'Database/db_helper.dart';
import 'package:flutter/material.dart';
import 'home.dart'; // Your Home widget
import 'search.dart'; // Create a Search widget
import 'locate.dart'; // Create a Locate widget
import 'profile_page.dart'; // Create a Profile widget
import 'notification_page.dart'; // Your Notification page
import 'auth_page.dart'; // Import LoginPage/ Import SignupPage
import 'otp_verification_page.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyDWfX36y0l6j21cHOF8kavGE4rpnVx2hA4",
          authDomain: "chill-cabs.firebaseapp.com",
          projectId: "chill-cabs",
          storageBucket: "chill-cabs.firebasestorage.app",
          messagingSenderId: "425034341046",
          appId: "1:425034341046:web:bbe448bcdf0442e2c8a417"
    ));
  }
  else{
  await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // Default route to login page
      routes: {
        '/': (context) => AuthPage(),
        '/otp': (context) => OtpVerificationPage(),
        '/home': (context) => MainNavigation(), // Your main navigation page
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Define a list of pages to navigate between
  final List<Widget> _pages = [
    Home(), // Your Home widget
    Search(), // Your Search widget
    Locate(),
    NotificationsPage(), // Your Notification widget
    ProfilePage(), // Your Profile widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set the current index
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex; // Update the selected index when tapped
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 25),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_searching_sharp, size: 25),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined, size: 30, color: Colors.amber), // Larger icon for Locate
            label: "Locate",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined, size: 25),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 25),
            label: "Profile",
          ),
        ],
        selectedItemColor: Colors.black, // Color for the selected icon
        unselectedItemColor: Colors.grey, // Color for unselected icons
        showUnselectedLabels: false, // Do not show labels
        showSelectedLabels: false, // Do not show labels
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
