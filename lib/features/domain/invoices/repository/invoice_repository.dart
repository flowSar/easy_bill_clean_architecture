import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import 'package:easy_bill_clean_architecture/features/domain/invoices/entities/invoice.dart';

abstract interface class InvoiceRepository {
  Future<Either<Failure, int>> addInvoice(
      Invoice invoice, List<InvoiceItem> items);

  Future<Either<Failure, List<Invoice>>> getInvoices();

  Future<Either<Failure, int>> deleteInvoice(String id);
}
