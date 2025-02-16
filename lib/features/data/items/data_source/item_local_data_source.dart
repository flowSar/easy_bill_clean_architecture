import 'package:easy_bill_clean_architecture/core/database/database_helper.dart';
import 'package:easy_bill_clean_architecture/core/error/exception.dart';
import 'package:easy_bill_clean_architecture/features/data/items/models/item_model.dart';
import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';

abstract interface class ItemLocalDataSource {
  Future<int> addItem(Item item);

  Future<List<Item>> getItems();

  Future<int> deleteItem(int id);

  Future<int> updateItem(Item item);
}

class ItemLocalDataSourceImpl implements ItemLocalDataSource {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  Future<int> addItem(Item item) async {
    try {
      final database = await databaseHelper.database;
      if (database != null) {
        return await database.insert(
            'items', ItemModel.fromEntity(item).toMap());
      } else {
        throw ServerException('database creation failed database=null');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<Item>> getItems() async {
    try {
      final database = await databaseHelper.database;
      if (database != null) {
        final result = await database.query('items');
        return result.map((item) => ItemModel.fromJson(item)).toList();
      } else {
        throw ServerException('database creation failed database=null');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> deleteItem(int id) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<int> updateItem(Item item) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }
}
