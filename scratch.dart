void main() {
  List<int> ids = [1, 3, 5];
  List<int> numbers = [1, 6, 1, 5, 3, 3, 1];

  print(numbers.where((num) => ids.contains(num)));

  // final settings = SettingsState(currency: 'dh', isDarkMode: false);
  final settings = SettingsState.initial();

  final settingsUp = SettingsUpdated(currency: '\$');
  print(settingsUp.currency);
  print(settingsUp.isDarkMode);
}

class SettingsState {
  final String? currency;
  final bool? isDarkMode;

  const SettingsState({
    this.currency,
    this.isDarkMode,
  });

  factory SettingsState.initial() {
    return const SettingsState(currency: 'USD', isDarkMode: false);
  }

  SettingsState copyWith({
    String? currency,
    bool? isDarkMode,
  }) {
    return SettingsState(
      currency: currency ?? this.currency,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

class SettingsUpdated extends SettingsState {
  SettingsUpdated({required super.currency});
}
