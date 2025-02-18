import '../../../domain/invoices/entities/invoice.dart';

abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class InvoiceSuccess extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoicesLoaded extends InvoiceState {
  final List<Invoice> invoices;

  InvoicesLoaded({required this.invoices});
}

class InvoiceItemLoaded extends InvoiceState {
  final List<InvoiceItem> invoiceItem;

  InvoiceItemLoaded(this.invoiceItem);
}

class InvoiceFailed extends InvoiceState {
  final String error;

  InvoiceFailed(this.error);
}
