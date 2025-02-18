import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/invoice.dart';
import '../repository/invoice_repository.dart';

abstract interface class InvoiceUseCase {
  Future<Either<Failure, int>> addInvoice(
      Invoice invoice, List<InvoiceItem> items);

  Future<Either<Failure, List<Invoice>>> getInvoices();

  Future<Either<Failure, int>> deleteInvoice(String id);
}

class InvoiceUseCaseImpl implements InvoiceUseCase {
  final InvoiceRepository repository;

  InvoiceUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, int>> deleteInvoice(String id) {
    return repository.deleteInvoice(id);
  }

  @override
  Future<Either<Failure, List<Invoice>>> getInvoices() {
    return repository.getInvoices();
  }

  @override
  Future<Either<Failure, int>> addInvoice(
      Invoice invoice, List<InvoiceItem> items) {
    return repository.addInvoice(invoice, items);
  }
}
