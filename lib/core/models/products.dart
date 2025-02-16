class Product {
  final String name;
  final int quantity;
  final double price;
  final double total;
  final String barCode;

  Product(
      {required this.barCode,
      required this.name,
      required this.quantity,
      required this.price,
      required this.total});
}

List<Product> products = [
  Product(
      barCode: '09876545',
      name: 'signal',
      quantity: 10,
      price: 12.5,
      total: 120),
];
