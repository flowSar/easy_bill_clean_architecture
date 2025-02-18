import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/exception.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import 'package:easy_bill_clean_architecture/features/data/invoices/data_source/invoice_local_data_source.dart';
import 'package:easy_bill_clean_architecture/features/domain/invoices/entities/invoice.dart';
import 'package:easy_bill_clean_architecture/features/domain/invoices/repository/invoice_repository.dart';

import '../models/invoice_model.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final InvoiceLocalDataSource invoiceLocalDataSource;

  InvoiceRepositoryImpl(this.invoiceLocalDataSource);

  @override
  Future<Either<Failure, int>> deleteInvoice(String id) async {
    try {
      final result = await invoiceLocalDataSource.deleteInvoice(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Invoice>>> getInvoices() async {
    try {
      final result = await invoiceLocalDataSource.getInvoices();
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> addInvoice(
      Invoice invoice, List<InvoiceItem> items) async {
    try {
      final result = await invoiceLocalDataSource.addInvoice(
        InvoiceModel.fromEntity(invoice),
        items.map((item) => InvoiceItemModel.fromEntity(item)).toList(),
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
