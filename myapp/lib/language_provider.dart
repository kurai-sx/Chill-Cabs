import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _selectedLanguage = 'English';

  String get selectedLanguage => _selectedLanguage;

  void changeLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners(); // Notify widgets about the language change
  }
}
