import 'package:easy_bill_clean_architecture/core/database/database_helper.dart';
import 'package:easy_bill_clean_architecture/core/error/exception.dart';
import 'package:easy_bill_clean_architecture/features/data/business_info/models/business_info_model.dart';
import 'package:easy_bill_clean_architecture/features/domain/business_info/entity/business_info_entity.dart';

abstract interface class BusinessInfoLocalDataSource {
  Future<int> addBusinessInfo(BusinessInfoModel businessInfo);

  Future<BusinessInfoModel> getBusinessInfo();

  Future<int> updateBusinessInfo(BusinessInfoModel businessInfo);
}

class BusinessInfoLocalDataSourceImpl implements BusinessInfoLocalDataSource {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Future<int> addBusinessInfo(BusinessInfoModel businessInfo) async {
    try {
      final database = await databaseHelper.database;
      if (database != null) {
        return database.insert('businessInfo', businessInfo.toMap());
      } else {
        throw Exception('database creation failed database = null');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BusinessInfoModel> getBusinessInfo() async {
    try {
      final database = await databaseHelper.database;
      if (database != null) {
        final result = await database.query('businessInfo');
        if (result.isEmpty) {
          print('throw');
          throw Exception('Business Info doen\'t exist');
        }
        return BusinessInfoModel.fromJson(result[0]);
      } else {
        throw ServerException('database creation failed database = null');
      }
    } on ServerException catch (e) {
      throw ServerException(e.errorMsg);
    }
  }

  @override
  Future<int> updateBusinessInfo(BusinessInfoModel businessInfo) async {
    try {
      final database = await databaseHelper.database;
      if (database != null) {
        final result = await database.update(
          'businessInfo',
          businessInfo.toMap(),
          where: 'id=?',
          whereArgs: [businessInfo.id],
        );
        return result;
        ;
      } else {
        throw ServerException('database creation failed database = null');
      }
    } on ServerException catch (e) {
      throw ServerException(e.errorMsg);
    }
  }
}
