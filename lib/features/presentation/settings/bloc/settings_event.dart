import 'dart:io';

abstract class SettingsEvent {}

class SetCurrencyEvent extends SettingsEvent {
  final String currency;

  SetCurrencyEvent(this.currency);
}

class GetCurrencyEvent extends SettingsEvent {}

class SetThemeModeEvent extends SettingsEvent {
  final bool isDarkMode;

  SetThemeModeEvent(this.isDarkMode);
}

class GetThemeModeEvent extends SettingsEvent {}

class SetSignatureEvent extends SettingsEvent {
  final File signature;

  SetSignatureEvent(this.signature);
}

class GetSignatureEvent extends SettingsEvent {}
