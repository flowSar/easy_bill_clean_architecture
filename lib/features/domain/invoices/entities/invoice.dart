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

class InvoiceItem {
  final int? id;
  final String name;
  final double quantity;
  final double price;
  final double tax;
  final double total;
  final String unit;
  final String invoiceId;

  InvoiceItem({
    this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
    required this.tax,
    required this.unit,
    required this.invoiceId,
  });
}
