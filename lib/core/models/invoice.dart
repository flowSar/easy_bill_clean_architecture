
import 'package:uuid/uuid.dart';

// this class will represent the items of the invoice
class InvoiceItem {
  final String _name;
  final double _quantity;
  final double _price;
  final double _tax;
  final double _total;
  final String _unit;
  final String _invoiceId;

  InvoiceItem({
    required name,
    required quantity,
    required price,
    required total,
    required tax,
    required unit,
    required invoiceId,
  })  : _name = name,
        _invoiceId = invoiceId,
        _quantity = quantity,
        _price = price,
        _tax = tax,
        _total = total,
        _unit = unit;

  String get name => _name;

  String get BillId => _invoiceId;

  double get quantity => _quantity;

  double get price => _price;

  double get tax => _tax;

  double get total => _total;

  String get unit => _unit;

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'quantity': _quantity,
      'price': _price,
      'tax': _tax,
      'total': _total,
      'unit': _unit,
      'invoiceId': _invoiceId,
    };
  }
}

// this modula represent the invoice that will store in the database
// and it will only include the important info of the bill and it won't include the items
// because the item will be stored in a separate table
class Invoice {
  final String _id;
  final String _date;
  final String _invoiceNumber;
  final int _clientId;
  final double _total;
  final double _pay;
  final double _rest;
  final List<InvoiceItem> _items;

  Invoice({
    required id,
    required clientId,
    required date,
    required total,
    required invoiceNumber,
    required rest,
    required pay,
    items,
  })  : _id = id,
        _clientId = clientId,
        _date = date,
        _total = total,
        _rest = rest,
        _pay = pay,
        _invoiceNumber = invoiceNumber,
        _items = items;

  String get id => _id;

  int get clientId => _clientId;

  String get billDate => _date;

  double get total => _total;

  double get pay => _pay;

  double get rest => _rest;

  String get billNumber => _invoiceNumber;

  List<InvoiceItem> get items => _items;

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'invoiceNumber': _invoiceNumber,
      'date': _date,
      'total': _total,
      'pay': pay,
      'rest': rest,
      'clientId': clientId,
    };
  }

  Map<String, dynamic> allToMap() {
    return {
      'id': _id,
      'invoiceNumber': _invoiceNumber,
      'date': _date,
      'total': _total,
      'pay': pay,
      'rest': rest,
      'clientId': clientId,
      'items': items.map((item) => item.toMap()).toList()
    };
  }
}

// this module for the whole invoice including the client info and the all items of the inoice
class GeneralInvoice {
  final String _id;
  final String _date;
  final String _invoiceNumber;
  final String _clientName;
  final String _clientAddress;
  final String _clientEmail;
  final String _clientPhoneNumber;
  final double _total;
  final double _pay;
  final double _rest;
  final List<InvoiceItem> _items;

  GeneralInvoice({
    required id,
    required clientId,
    required date,
    required total,
    required clientName,
    required clientAddress,
    required clientEmail,
    required clientPhoneNumber,
    required invoiceNumber,
    required rest,
    required pay,
    required items,
  })  : _id = id,
        _date = date,
        _clientName = clientName,
        _clientAddress = clientAddress,
        _clientEmail = clientEmail,
        _clientPhoneNumber = clientPhoneNumber,
        _items = items,
        _total = total,
        _rest = rest,
        _pay = pay,
        _invoiceNumber = invoiceNumber;

  String get id => _id;

  String get billDate => _date;

  String get clientName => _clientName;

  String get clientAddress => _clientAddress;

  String get clientEmail => _clientEmail;

  String get clientPhoneNumber => _clientPhoneNumber;

  double get total => _total;

  double get pay => _pay;

  double get rest => _rest;

  String get billNumber => _invoiceNumber;

  List<InvoiceItem> get items => _items;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': _date,
      'invoiceNumber': _invoiceNumber,
      'clientName': clientName,
      'clientAddress': clientAddress,
      'clientEmail': clientEmail,
      'clientPhoneNumber': clientPhoneNumber,
      'total': _total,
      'pay': pay,
      'rest': rest,
      'items': items.map((item) => item.toMap()).toList()
    };
  }
}
