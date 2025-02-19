import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';

abstract interface class ItemEvent {}

class GetItemEvent implements ItemEvent {}

class AddItemEvent implements ItemEvent {
  final Item item;

  AddItemEvent({required this.item});
}

class DeleteItemEvent implements ItemEvent {
  final int id;

  DeleteItemEvent({required this.id});
}

class UpdateItemEvent implements ItemEvent {
  final Item item;
  final int id;

  UpdateItemEvent({required this.item, required this.id});
}

class FilterItemsEvent implements ItemEvent {
  final String name;

  FilterItemsEvent({required this.name});
}
