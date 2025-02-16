import 'package:easy_bill_clean_architecture/features/domain/business_info/entity/business_info_entity.dart';

abstract class BusinessInfoEvent {}

class GetBusinessInfoEvent extends BusinessInfoEvent {}

class AddBusinessInfoEvent extends BusinessInfoEvent {
  final BusinessInfo businessInfo;

  AddBusinessInfoEvent({required this.businessInfo});
}

class UpdateBusinessInfoEvent extends BusinessInfoEvent {
  final BusinessInfo businessInfo;

  UpdateBusinessInfoEvent({required this.businessInfo});
}
