import 'dart:io';

import 'package:easy_bill_clean_architecture/features/domain/settings/repository/settings_repository.dart';

abstract interface class SettingsUseCase {
  Future<void> setThemeMode(bool isDarkMode);

  Future<bool> getThemeMode();

  Future<void> setCurrency(String currency);

  Future<String> getCurrency();

  Future<void> setSignature(File file);

  Future<File> getSignature();
}

class SettingsUseCaseImpl implements SettingsUseCase {
  final SettingsRepository repository;

  SettingsUseCaseImpl(this.repository);

  @override
  Future<String> getCurrency() {
    return repository.getCurrency();
  }

  @override
  Future<File> getSignature() {
    return repository.getSignature();
  }

  @override
  Future<bool> getThemeMode() {
    return repository.getThemeMode();
  }

  @override
  Future<void> setCurrency(String currency) {
    return repository.setCurrency(currency);
  }

  @override
  Future<void> setSignature(File file) {
    return repository.setSignature(file);
  }

  @override
  Future<void> setThemeMode(bool isDarkMode) {
    return repository.setThemeMode(isDarkMode);
  }
}
