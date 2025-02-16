import 'dart:ui';

class Language {
  final String _name;
  final String _language;

  Language({required name, required language})
      : _name = name,
        _language = language;

  String get name => _name;

  String get language => _language;

  Locale get locale => Locale(_language);
}

List<Language> languages = [
  Language(name: 'English', language: 'en'),
  Language(name: 'Arabic', language: 'ar'),
  Language(name: 'French', language: 'fr'),
];
