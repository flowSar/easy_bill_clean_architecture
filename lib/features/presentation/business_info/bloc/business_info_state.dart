import 'package:easy_bill_clean_architecture/features/domain/business_info/entity/business_info_entity.dart';

abstract class BusinessInfoState {}

class BusinessInfoInitial extends BusinessInfoState {}

class BusinessInfoLoading extends BusinessInfoState {}

class BusinessInfoLoaded extends BusinessInfoState {
  final BusinessInfo businessInfo;

  BusinessInfoLoaded({required this.businessInfo});
}

class BusinessInfoSuccess extends BusinessInfoState {}

class BusinessInfoUpdateSuccess extends BusinessInfoState {}

class BusinessInfoFailed extends BusinessInfoState {
  final String error;

  BusinessInfoFailed(this.error);
}

class BusinessInfoUpdateFailed extends BusinessInfoState {
  final String error;

  BusinessInfoUpdateFailed(this.error);
}
