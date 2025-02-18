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
    required super.items,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json,
      {List<InvoiceItem>? items}) {
    return InvoiceModel(
      id: json['id'],
      clientId: json['clientId'],
      date: json['date'],
      total: json['total'],
      invoiceNumber: json['invoiceNumber'],
      rest: json['rest'],
      pay: json['pay'],
      items: items,
    );
  }

  factory InvoiceModel.fromEntity(Invoice invoice) {
    return InvoiceModel(
      id: invoice.id,
      clientId: invoice.clientId,
      date: invoice.date,
      total: invoice.total,
      invoiceNumber: invoice.invoiceNumber,
      rest: invoice.rest,
      pay: invoice.pay,
      items: invoice.items,
    );
  }

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

class InvoiceItemModel extends InvoiceItem {
  InvoiceItemModel({
    super.id,
    required super.name,
    required super.quantity,
    required super.price,
    required super.total,
    required super.tax,
    required super.unit,
    required super.invoiceId,
  });

  factory InvoiceItemModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      total: json['total'],
      tax: json['tax'],
      unit: json['unit'],
      invoiceId: json['invoiceId'],
    );
  }

  factory InvoiceItemModel.fromEntity(InvoiceItem invoiceItem) {
    return InvoiceItemModel(
      name: invoiceItem.name,
      quantity: invoiceItem.quantity,
      price: invoiceItem.price,
      total: invoiceItem.total,
      tax: invoiceItem.tax,
      unit: invoiceItem.unit,
      invoiceId: invoiceItem.invoiceId,
    );
  }

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
