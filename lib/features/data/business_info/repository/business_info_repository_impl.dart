import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/exception.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import 'package:easy_bill_clean_architecture/features/data/business_info/data_source/business_local_data_source.dart';
import 'package:easy_bill_clean_architecture/features/data/business_info/models/business_info_model.dart';
import 'package:easy_bill_clean_architecture/features/domain/business_info/entity/business_info_entity.dart';
import 'package:easy_bill_clean_architecture/features/domain/business_info/repository/business_info_repository.dart';

class BusinessInfoRepositoryImpl implements BusinessInfoRepository {
  final BusinessInfoLocalDataSource businessInfoLocalDataSource;

  BusinessInfoRepositoryImpl(this.businessInfoLocalDataSource);

  @override
  Future<Either<Failure, int>> addBusinessInfo(
      BusinessInfo businessInfo) async {
    try {
      final result = await businessInfoLocalDataSource.addBusinessInfo(
        BusinessInfoModel.fromEntity(businessInfo),
      );
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BusinessInfo>> getBusinessInfo() async {
    try {
      final result = await businessInfoLocalDataSource.getBusinessInfo();
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> updateBusinessInfo(
      BusinessInfo businessInfo) async {
    try {
      final result = await businessInfoLocalDataSource.updateBusinessInfo(
        BusinessInfoModel.fromEntity(businessInfo),
      );
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
