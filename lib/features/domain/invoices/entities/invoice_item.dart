class InvoiceItem {
  final String name;
  final double quantity;
  final double price;
  final double tax;
  final double total;
  final String unit;
  final String invoiceId;

  InvoiceItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
    required this.tax,
    required this.unit,
    required this.invoiceId,
  });
}
