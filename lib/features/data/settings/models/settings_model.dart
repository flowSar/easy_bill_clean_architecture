import 'package:easy_bill_clean_architecture/features/domain/settings/entities/settings_entity.dart';

class SettingsModel extends Settings {
  SettingsModel({super.isDarkMode, super.currency});

  factory SettingsModel.fromEntity(Settings settings) {
    return SettingsModel(
        isDarkMode: settings.isDarkMode, currency: settings.currency);
  }
}
