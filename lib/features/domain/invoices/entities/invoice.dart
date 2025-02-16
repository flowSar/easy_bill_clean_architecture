import 'invoice_item.dart';

class Invoice {
  final String id;
  final String date;
  final String invoiceNumber;
  final int clientId;
  final double total;
  final double pay;
  final double rest;
  final List<InvoiceItem>? items;

  Invoice({
    required this.id,
    required this.clientId,
    required this.date,
    required this.total,
    required this.invoiceNumber,
    required this.rest,
    required this.pay,
    this.items,
  });
}
