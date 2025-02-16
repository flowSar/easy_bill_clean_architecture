import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import 'package:easy_bill_clean_architecture/features/domain/business_info/entity/business_info_entity.dart';

abstract interface class BusinessInfoRepository {
  Future<Either<Failure, int>> addBusinessInfo(BusinessInfo businessInfo);

  Future<Either<Failure, BusinessInfo>> getBusinessInfo();

  Future<Either<Failure, int>> updateBusinessInfo(BusinessInfo businessInfo);
}
