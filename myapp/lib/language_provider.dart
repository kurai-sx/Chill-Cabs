import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String _selectedLanguageCode = 'en'; // ✅ Default to English

  String get selectedLanguageCode => _selectedLanguageCode;

  Future<void> changeLanguage(String languageCode) async {
    _selectedLanguageCode = languageCode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedLanguageCode = prefs.getString('language_code') ?? 'en';
    notifyListeners();
  }
}
