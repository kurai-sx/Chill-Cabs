import 'package:ChillCabs/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'locate.dart';
import 'notification_page.dart';
import 'theme_provider.dart';  // Import theme provider
import 'language_provider.dart';  // Import language provider
import 'home.dart';
import 'profile_page.dart';
import 'auth_page.dart';
import 'otp_verification_page.dart';
import 'profile_page_options.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),  // ✅ Manage Theme
        ChangeNotifierProvider(create: (context) => LanguageProvider()),  // ✅ Manage Language
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode, // ✅ Use global theme mode
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthPage(),
        '/otp': (context) => OtpVerificationPage(),
        '/home': (context) => MainNavigation(),
        '/settings': (context) => SettingsPage(),
        '/privacy': (context) => PrivacyPage(),
        '/help': (context) => HelpPage(),
        '/mobile_auth': (context) => AuthPage(),
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

  final List<Widget> _pages = [
    Home(),
    Search(),
    Locate(),
    NotificationsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
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
            icon: Icon(Icons.location_on_outlined, size: 30, color: Colors.amber),
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
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
