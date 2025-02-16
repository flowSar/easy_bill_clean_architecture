import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';

// abstract interface class ItemUseCase<T, Params> {
//   Future<Either<Failure, T>> call(Params param);
// }

abstract interface class ItemUseCases {
  Future<Either<Failure, int>> addItem(Item item);

  Future<Either<Failure, List<Item>>> getItems();

  Future<Either<Failure, int>> deleteItem(int id);

  Future<Either<Failure, int>> updateItem(Item item);
}

class NoParams {}
