import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import 'package:easy_bill_clean_architecture/features/data/items/data_source/item_local_data_source.dart';
import 'package:easy_bill_clean_architecture/features/domain/items/repository/item_repository.dart';
import '../../../domain/items/entity/item.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemLocalDataSource itemLocalDataSource;

  ItemRepositoryImpl(this.itemLocalDataSource);

  @override
  Future<Either<Failure, int>> addItem(Item item) async {
    try {
      final result = await itemLocalDataSource.addItem(item);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Item>>> getItems() async {
    try {
      final result = await itemLocalDataSource.getItems();
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteItem(int id) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> updateItem(Item item) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }
}
