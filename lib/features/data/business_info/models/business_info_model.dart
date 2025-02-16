import 'dart:convert';

import 'package:easy_bill_clean_architecture/features/domain/business_info/entity/business_info_entity.dart';

class BusinessInfoModel extends BusinessInfo {
  BusinessInfoModel({
    super.id,
    required super.businessName,
    super.businessAddress,
    super.businessEmail,
    super.businessPhoneNumber,
  });

  factory BusinessInfoModel.fromEntity(BusinessInfo businessInfo) {
    return BusinessInfoModel(
      id: businessInfo.id,
      businessName: businessInfo.businessName,
      businessAddress: businessInfo.businessAddress,
      businessEmail: businessInfo.businessEmail,
      businessPhoneNumber: businessInfo.businessPhoneNumber,
    );
  }

  factory BusinessInfoModel.fromJson(Map<String, dynamic> json) {
    return BusinessInfoModel(
      id: json['id'],
      businessName: json['businessName'],
      businessAddress: json['businessAddress'],
      businessEmail: json['businessEmail'],
      businessPhoneNumber: json['businessPhoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'businessName': super.businessName,
      'businessAddress': super.businessAddress,
      'businessEmail': super.businessEmail,
      'businessPhoneNumber': super.businessPhoneNumber
    };
  }
}
