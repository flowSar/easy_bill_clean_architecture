import 'package:easy_bill_clean_architecture/features/domain/business_info/user_cases/business_info_use_case_impl.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessInfoBloc extends Bloc<BusinessInfoEvent, BusinessInfoState> {
  final BusinessInfoUseCase businessInfoUseCase;

  BusinessInfoBloc(this.businessInfoUseCase) : super(BusinessInfoInitial()) {
    on<AddBusinessInfoEvent>(_addBusinessInfo);
    on<GetBusinessInfoEvent>(_getBusinessInfo);
    on<UpdateBusinessInfoEvent>(_updateBusinessInfo);
  }

  void _addBusinessInfo(
      BusinessInfoEvent event, Emitter<BusinessInfoState> emit) async {
    try {
      final businessInfo = (event as AddBusinessInfoEvent).businessInfo;
      final result = await businessInfoUseCase.addBusinessInfo(businessInfo);
      result.fold((failure) {
        emit(BusinessInfoFailed(failure.error));
      }, (res) {
        if (res == 1) {
          emit(BusinessInfoSuccess());
        } else {
          emit(BusinessInfoFailed('business info adding failed'));
        }
      });
    } catch (e) {
      emit(BusinessInfoFailed(e.toString()));
    }
  }

  void _getBusinessInfo(
      BusinessInfoEvent event, Emitter<BusinessInfoState> emit) async {
    try {
      emit(BusinessInfoLoading());
      final result = await businessInfoUseCase.getBusinessInfo();
      emit(BusinessInfoSuccess());
      result.fold((failure) {
        emit(BusinessInfoFailed(failure.error));
      }, (res) {
        emit(BusinessInfoLoaded(businessInfo: res));
      });
    } catch (e) {
      emit(BusinessInfoFailed(e.toString()));
    }
  }

  void _updateBusinessInfo(
      BusinessInfoEvent event, Emitter<BusinessInfoState> emit) async {
    try {
      emit(BusinessInfoLoading());
      final businessInfo = (event as UpdateBusinessInfoEvent).businessInfo;
      final result = await businessInfoUseCase.updateBusinessInfo(businessInfo);
      result.fold((failure) {
        emit(BusinessInfoUpdateFailed(failure.error));
      }, (res) {
        print('result: $res');
        if (res == 1) {
          emit(BusinessInfoUpdateSuccess());
        } else {
          emit(BusinessInfoUpdateFailed('updating the business Info failed'));
        }
      });
    } catch (e) {
      print('error updating');
      emit(BusinessInfoUpdateFailed(e.toString()));
    }
  }
}
