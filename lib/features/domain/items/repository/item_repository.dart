import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';

import '../../../../core/error/failure.dart';

abstract interface class ItemRepository {
  Future<Either<Failure, int>> addItem(Item item);

  Future<Either<Failure, List<Item>>> getItems();

  Future<Either<Failure, int>> deleteItem(int id);

  Future<Either<Failure, int>> updateItem(Item item);
}
