import 'dart:io';

abstract interface class SettingsRepository {
  Future<void> setThemeMode(bool isDarkMode);

  Future<bool> getThemeMode();

  Future<void> setCurrency(String currency);

  Future<String> getCurrency();

  Future<void> setSignature(File file);

  Future<File> getSignature();
}
