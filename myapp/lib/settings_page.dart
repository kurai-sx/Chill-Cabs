import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';
  List<String> languages = ['English', 'Hindi', 'Spanish', 'French'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.amber,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.brightness_6, color: Colors.amber),
            title: Text("Dark Mode"),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language, color: Colors.amber),
            title: Text("Language"),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              items: languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
