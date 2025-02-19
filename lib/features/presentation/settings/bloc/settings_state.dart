import 'dart:io';

class SettingsState {
  final String? currency;
  final bool? isDarkMode;

  SettingsState({this.currency, this.isDarkMode});

  factory SettingsState.initial() {
    return SettingsState(currency: 'dh', isDarkMode: false);
  }

  SettingsState copyWith({String? currency, bool? isDarkMode}) {
    return SettingsState(
        currency: currency ?? this.currency,
        isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}

// class SettingsCurrencyUpdated extends SettingsState {
//   final String currency;
//
//   SettingsCurrencyUpdated({required this.currency});
// }

class SettingsUpdateFailed extends SettingsState {
  final String error;

  SettingsUpdateFailed(this.error);
}

// class SettingsThemeModeUpdated extends SettingsState {
//   final bool isDarkMode;
//
//   SettingsThemeModeUpdated({required this.isDarkMode});
// }

class SettingsSignatureUpdated extends SettingsState {}
