import 'package:easy_bill_clean_architecture/features/domain/invoices/entities/invoice_item.dart';

class InvoiceItemModel extends InvoiceItem {
  InvoiceItemModel({
    required super.name,
    required super.quantity,
    required super.price,
    required super.total,
    required super.tax,
    required super.unit,
    required super.invoiceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'tax': tax,
      'total': total,
      'unit': unit,
      'invoiceId': invoiceId,
    };
  }
}
