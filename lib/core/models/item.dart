class Item {
  final int? _id;
  final String? _barCode;
  final String _name;
  final String? _description;
  final double _price;
  final double _quantity;
  final double? _tax;
  final String? _unit;
  final double? _stock;

  Item({
    id,
    required barCode,
    required name,
    required description,
    required double price,
    required quantity,
    required tax,
    required unit,
    required stock,
  })  : _id = id,
        _barCode = barCode,
        _name = name,
        _description = description,
        _price = price,
        _quantity = quantity,
        _tax = tax,
        _unit = unit,
        _stock = stock;

  int? get id => _id;

  String? get barCode => _barCode;

  String get name => _name;

  String? get description => _description;

  double get price => _price;

  double get quantity => _quantity;

  double? get tax => _tax;

  String? get unit => _unit;

  double? get stock => _stock;

  Map<String, dynamic> toMap() {
    return {
      'barCode': barCode,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'stock': stock,
      'tax': tax,
      'unit': unit,
    };
  }
}

Item tmpItem = Item(
  barCode: '09876543212345',
  name: 'signal',
  description: 'description',
  price: 12.5,
  quantity: 10.0,
  tax: 10.0,
  unit: 'p',
  stock: 300.0,
);
