import 'package:easy_bill_clean_architecture/core/database/database_helper.dart';
import 'package:easy_bill_clean_architecture/core/error/exception.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/model/client.dart';

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

  Future<List<ClientModel>> getClients() async {
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

  Future<int> updateClient(Client client) async {
    final db = await databaseHelper.database;
    try {
      if (db != null) {
        return await db.update(
            'clients', ClientModel.fromEntity(client).toMap(),
            where: 'id=?', whereArgs: [client.id]);
      }
      throw ServerException('insert failed database = null');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<int> deleteClient(int id) async {
    final db = await databaseHelper.database;
    try {
      if (db != null) {
        return await db.delete('clients', where: 'id=?', whereArgs: [id]);
      }
      throw ServerException('insert failed database = null');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<ClientModel> getClient(int id) async {
    final db = await databaseHelper.database;
    try {
      if (db != null) {
        final results =
            await db.query('clients', where: 'id=?', whereArgs: [id]);
        ClientModel.fromJson(results[0]);
      }
      throw ServerException('insert failed database = null');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
