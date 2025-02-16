import 'package:easy_bill_clean_architecture/core/database/database_helper.dart';
import 'package:easy_bill_clean_architecture/core/error/exception.dart';

import '../models/client_model.dart';

class ClientLocalDataSource {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<int> addClient(ClientModel client) async {
    final db = await databaseHelper.database;
    try {
      if (db != null) {
        final result = await db.insert('clients', client.toMap());
        return result;
      }
      throw ServerException('insert failed database = null');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<ClientModel>> getClient() async {
    final db = await databaseHelper.database;
    try {
      if (db != null) {
        final results = await db.query('clients');
        return results.map((client) => ClientModel.fromJson(client)).toList();
      }
      throw ServerException('insert failed database = null');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<void> updateClient(ClientModel client) async {}

  Future<void> deleteClient(int id) async {}
}
