import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';

class ItemModel extends Item {
  ItemModel({
    super.id,
    super.barCode,
    required super.name,
    super.description,
    super.quantity,
    required super.price,
    required super.unit,
    super.tax,
    super.stock,
  });

  Map<String, dynamic> toMap() {
    return {
      'barCode': super.barCode,
      'name': super.name,
      'description': super.description,
      'quantity': super.quantity,
      'price': super.quantity,
      'unit': super.unit,
      'tax': super.tax,
      'stock': super.stock
    };
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      barCode: json['barCode'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      unit: json['unit'],
      tax: json['tax'],
      stock: json['stock'],
    );
  }

  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      barCode: item.barCode,
      name: item.name,
      description: item.description,
      price: item.price,
      quantity: item.quantity,
      unit: item.unit,
      tax: item.tax,
      stock: item.stock,
    );
  }
}
