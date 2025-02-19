import 'package:easy_bill_clean_architecture/features/domain/settings/use_cases/signature_use_case.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsUseCase settingsUseCase;

  SettingsBloc(this.settingsUseCase) : super(SettingsState.initial()) {
    on<SetCurrencyEvent>(_setCurrency);
    on<GetCurrencyEvent>(_getCurrency);
    on<SetThemeModeEvent>(_setThemeMode);
    on<GetThemeModeEvent>(_getThemeMode);
    on<SetSignatureEvent>(_setSignature);
    on<GetSignatureEvent>(_getSignature);
  }

  Future<void> _setCurrency(
      SetCurrencyEvent event, Emitter<SettingsState> emit) async {
    try {
      await settingsUseCase.setCurrency(event.currency);
      emit(state.copyWith(currency: event.currency));
    } catch (e) {
      emit(SettingsUpdateFailed(e.toString()));
    }
  }

  Future<void> _getCurrency(
      GetCurrencyEvent event, Emitter<SettingsState> emit) async {
    try {
      final result = await settingsUseCase.getCurrency();
      emit(state.copyWith(
        currency: result,
      ));
    } catch (e) {
      emit(SettingsUpdateFailed(e.toString()));
    }
  }

  Future<void> _setThemeMode(
      SetThemeModeEvent event, Emitter<SettingsState> emit) async {
    try {
      await settingsUseCase.setThemeMode(event.isDarkMode);
      emit(state.copyWith(isDarkMode: event.isDarkMode));
    } catch (e) {
      emit(SettingsUpdateFailed(e.toString()));
    }
  }

  Future<void> _getThemeMode(
      GetThemeModeEvent event, Emitter<SettingsState> emit) async {
    try {
      final result = await settingsUseCase.getThemeMode();
      emit(state.copyWith(
        isDarkMode: result,
      ));
    } catch (e) {
      emit(SettingsUpdateFailed(e.toString()));
    }
  }

  Future<void> _setSignature(
      SettingsEvent event, Emitter<SettingsState> emit) async {}

  Future<void> _getSignature(
      SettingsEvent event, Emitter<SettingsState> emit) async {}
}
