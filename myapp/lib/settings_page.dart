import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'language_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final languageProvider = Provider.of<LanguageProvider>(context, listen: true);
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: Text("Settings"), backgroundColor: Colors.amber),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.brightness_6, color: Colors.amber),
              title: Text("Dark Mode"),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value); // ✅ Ensure Theme Updates
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.language, color: Colors.amber),
              title: Text("Language"),
              trailing: DropdownButton<String>(
                value: languageProvider.selectedLanguage.isNotEmpty ? languageProvider.selectedLanguage : 'English', // ✅ Ensure a Default Value
                items: ['English', 'Hindi', 'Spanish', 'French'].map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue != null) {
                    languageProvider.changeLanguage(newValue); // ✅ Ensure Language Updates
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
