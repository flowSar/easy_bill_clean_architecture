import 'dart:io';

class SettingsState {
  final String? currency;
  final bool? isDarkMode;
  final File? signature;

  SettingsState({this.currency, this.isDarkMode, this.signature});

  factory SettingsState.initial() {
    return SettingsState(currency: 'dh', isDarkMode: false);
  }

  SettingsState copyWith(
      {String? currency, bool? isDarkMode, File? signature}) {
    return SettingsState(
      currency: currency ?? this.currency,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      signature: signature ?? this.signature,
    );
  }
}

class SettingsUpdateFailed extends SettingsState {
  final String error;

  SettingsUpdateFailed(this.error);
}

class SettingsSignatureUpdated extends SettingsState {}
