import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';

abstract class ItemState {}

class ItemInitialState extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemLoadedState extends ItemState {
  final List<Item> items;

  ItemLoadedState(this.items);
}

class ItemSuccessState extends ItemState {}

class ItemAdded extends ItemState {}

class ItemDeleted extends ItemState {}

class ItemDeletedFailed extends ItemState {
  final String error;

  ItemDeletedFailed(this.error);
}

class ItemUpdated extends ItemState {}

class ItemUpdatedFailed extends ItemState {
  final String error;

  ItemUpdatedFailed(this.error);
}

class ItemFailedState extends ItemState {
  final String error;

  ItemFailedState(this.error);
}
