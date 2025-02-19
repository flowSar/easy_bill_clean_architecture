import 'dart:io';

import 'package:easy_bill_clean_architecture/core/constance/g_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SettingsLocalDataSource {
  Future<bool> getThemeMode();

  Future<void> setThemeMode(bool isDarkMode);

  Future<String> getCurrency();

  Future<void> setCurrency(String currency);

  Future<File> getSignature();

  Future<void> setSignature(File file);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferencesAsync asyncPrefs;

  SettingsLocalDataSourceImpl(this.asyncPrefs);

  @override
  Future<String> getCurrency() async {
    final currency =
        await asyncPrefs.getString(SettingsKeys.currency.toString());
    if (currency != null) {
      return currency;
    }
    throw Exception('currency not found');
  }

  @override
  Future<File> getSignature() async {
    final path = await asyncPrefs.getString(SettingsKeys.signature.toString());
    if (path != null) {
      File file = File(path);
      return file;
    }
    throw Exception('signature path not found');
  }

  @override
  Future<bool> getThemeMode() async {
    final isDarkMode =
        await asyncPrefs.getBool(SettingsKeys.themeMode.toString());
    if (isDarkMode != null) {
      return isDarkMode;
    }
    throw Exception('DarkMode not found');
  }

  @override
  Future<void> setCurrency(String currency) async {
    await asyncPrefs.setString(SettingsKeys.currency.toString(), currency);
  }

  @override
  Future<void> setSignature(File file) async {
    await asyncPrefs.setString(SettingsKeys.signature.toString(), file.path);
  }

  @override
  Future<void> setThemeMode(bool isDarkMode) async {
    await asyncPrefs.setBool(SettingsKeys.themeMode.toString(), isDarkMode);
  }
}
