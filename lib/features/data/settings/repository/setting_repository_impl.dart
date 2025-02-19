import 'dart:io';

import 'package:easy_bill_clean_architecture/features/data/settings/data_source/settings_local_data_source.dart';
import 'package:easy_bill_clean_architecture/features/domain/settings/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource settingsLocalDataSource;

  SettingsRepositoryImpl(this.settingsLocalDataSource);

  @override
  Future<String> getCurrency() {
    try {
      return settingsLocalDataSource.getCurrency();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<File> getSignature() {
    try {
      return settingsLocalDataSource.getSignature();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> getThemeMode() {
    try {
      return settingsLocalDataSource.getThemeMode();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> setCurrency(String currency) {
    return settingsLocalDataSource.setCurrency(currency);
  }

  @override
  Future<void> setSignature(File file) {
    return settingsLocalDataSource.setSignature(file);
  }

  @override
  Future<void> setThemeMode(bool isDarkMode) {
    return settingsLocalDataSource.setThemeMode(isDarkMode);
  }
}
