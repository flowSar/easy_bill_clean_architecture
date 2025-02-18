import 'package:easy_bill_clean_architecture/features/data/invoices/models/invoice_model.dart';

import '../../../../core/database/database_helper.dart';
import '../../../../core/error/exception.dart';
import '../../../domain/invoices/entities/invoice.dart';

abstract interface class InvoiceLocalDataSource {
  Future<int> addInvoice(InvoiceModel invoice, List<InvoiceItemModel> items);

  Future<List<InvoiceModel>> getInvoices();

  Future<int> deleteInvoice(String id);
}

class InvoiceLocalDataSourceImpl implements InvoiceLocalDataSource {
  final DatabaseHelper instance = DatabaseHelper.instance;

  @override
  Future<int> addInvoice(
      InvoiceModel invoice, List<InvoiceItemModel> items) async {
    try {
      final db = await instance.database;
      late int result;
      if (db != null) {
        // insert the invoice database.
        result = await db.insert('invoices', invoice.toMap());
        // check if the invoice inserted
        if (result != 0) {
          // insert the invoice items
          for (final item in items) {
            result = await db.insert('invoiceItems', item.toMap());
          }
        } else {
          throw ServerException('invoice insertion failed database failed');
        }
        return result;
      } else {
        throw ServerException('create database failed');
      }
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> deleteInvoice(String id) async {
    try {
      final db = await instance.database;
      late int result;
      if (db != null) {
        result = await db.delete('invoices', where: 'id=?', whereArgs: [id]);
        if (result != 0) {
          result =
              await db.delete('invoiceItems', where: 'id=?', whereArgs: [id]);
        } else {
          throw ServerException('invoice delete failed');
        }
        return result;
      } else {
        throw ServerException('create database failed');
      }
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<InvoiceModel>> getInvoices() async {
    try {
      final db = await instance.database;
      if (db != null) {
        final result = await db.query('invoices');
        List<InvoiceModel> invoices = [];
        for (final invoice in result) {
          String id = invoice['id'] as String;
          List<InvoiceItem> items = await getInvoiceItem(id);
          invoices.add(InvoiceModel.fromJson(invoice, items: items));
        }
        return invoices;
      } else {
        throw ServerException('create database failed');
      }
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<InvoiceItem>> getInvoiceItem(String id) async {
    try {
      final db = await instance.database;
      if (db != null) {
        final result = await db
            .query('invoiceItems', where: 'invoiceId=?', whereArgs: [id]);
        return result.map((item) => InvoiceItemModel.fromJson(item)).toList();
      } else {
        throw ServerException('loading invoice items failed database=null');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
