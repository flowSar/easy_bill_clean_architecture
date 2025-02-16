class Item {
  final int? id;
  final String? barCode;
  final String name;
  final String? description;
  final double price;
  final double? quantity;
  final double? tax;
  final String? unit;
  final double? stock;

  Item({
    this.id,
    this.barCode,
    required this.name,
    this.description,
    required this.price,
    this.quantity,
    this.tax,
    required this.unit,
    this.stock,
  });
}
