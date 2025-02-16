import 'package:easy_bill_clean_architecture/features/domain/invoices/entities/invoice.dart';

class InvoiceModel extends Invoice {
  InvoiceModel({
    required super.id,
    required super.clientId,
    required super.date,
    required super.total,
    required super.invoiceNumber,
    required super.rest,
    required super.pay,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'invoiceNumber': super.invoiceNumber,
      'date': super.date,
      'total': super.total,
      'pay': super.pay,
      'rest': super.rest,
      'clientId': super.clientId,
    };
  }
}
