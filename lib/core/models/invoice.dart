import '../../features/data/invoices/models/invoice_model.dart';

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
  final List<InvoiceItemModel> _items;

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

  List<InvoiceItemModel> get items => _items;

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
