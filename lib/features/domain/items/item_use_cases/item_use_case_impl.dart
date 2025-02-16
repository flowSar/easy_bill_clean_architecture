import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import 'package:easy_bill_clean_architecture/core/use_case/item_use_case.dart';
import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';
import 'package:easy_bill_clean_architecture/features/domain/items/repository/item_repository.dart';

class ItemUseCaseImpl implements ItemUseCases {
  final ItemRepository itemRepository;

  ItemUseCaseImpl(this.itemRepository);

  @override
  Future<Either<Failure, int>> addItem(Item item) {
    return itemRepository.addItem(item);
  }

  @override
  Future<Either<Failure, int>> deleteItem(int id) {
    return itemRepository.deleteItem(id);
  }

  @override
  Future<Either<Failure, List<Item>>> getItems() {
    return itemRepository.getItems();
  }

  @override
  Future<Either<Failure, int>> updateItem(Item item) {
    return itemRepository.updateItem(item);
  }
}
