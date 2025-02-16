import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/features/domain/business_info/repository/business_info_repository.dart';

import '../../../../core/error/failure.dart';
import '../entity/business_info_entity.dart';

abstract interface class BusinessInfoUseCase {
  Future<Either<Failure, int>> addBusinessInfo(BusinessInfo businessInfo);

  Future<Either<Failure, BusinessInfo>> getBusinessInfo();

  Future<Either<Failure, int>> updateBusinessInfo(BusinessInfo businessInfo);
}

class BusinessInfoUseCaseImpl implements BusinessInfoUseCase {
  final BusinessInfoRepository repository;

  BusinessInfoUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, int>> addBusinessInfo(BusinessInfo businessInfo) {
    return repository.addBusinessInfo(businessInfo);
  }

  @override
  Future<Either<Failure, BusinessInfo>> getBusinessInfo() {
    return repository.getBusinessInfo();
  }

  @override
  Future<Either<Failure, int>> updateBusinessInfo(BusinessInfo businessInfo) {
    return repository.updateBusinessInfo(businessInfo);
  }
}
