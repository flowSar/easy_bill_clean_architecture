import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';

abstract class ItemState {}

class ItemInitialState extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemLoadedState extends ItemState {
  final List<Item> items;

  ItemLoadedState(this.items);
}

class ItemSuccessState extends ItemState {}

class ItemFailedState extends ItemState {
  final String error;

  ItemFailedState(this.error);
}
