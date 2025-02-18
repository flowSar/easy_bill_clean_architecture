import 'package:easy_bill_clean_architecture/features/domain/invoices/entities/invoice.dart';

abstract class InvoiceEvent {}

class GetInvoicesEvent extends InvoiceEvent {}

class AddInvoicesEvent extends InvoiceEvent {
  final Invoice invoice;
  final List<InvoiceItem> invoiceItems;

  AddInvoicesEvent(this.invoice, this.invoiceItems);
}

class DeleteInvoicesEvent extends InvoiceEvent {
  final String invoiceId;

  DeleteInvoicesEvent(this.invoiceId);
}

class GetInvoiceItemEvent extends InvoiceEvent {
  final String id;

  GetInvoiceItemEvent({required this.id});
}

class FilterInvoicesEvent extends InvoiceEvent {
  final List<int?> ids;

  FilterInvoicesEvent({required this.ids});
}
