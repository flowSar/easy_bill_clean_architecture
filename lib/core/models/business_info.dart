class BusinessInfo {
  final int _id;
  final String _businessName;
  final String? _businessAddress;
  final String? _businessEmail;
  final String? _businessPhoneNumber;

  BusinessInfo(
      {id,
      required businessName,
      businessAddress,
      businessEmail,
      businessPhoneNumber})
      : _id = id,
        _businessName = businessName,
        _businessAddress = businessAddress,
        _businessEmail = businessEmail,
        _businessPhoneNumber = businessPhoneNumber;

  int get id => _id;

  String get businessName => _businessName;

  String? get businessAddress => _businessAddress;

  String? get businessEmail => _businessEmail;

  String? get businessPhoneNumber => _businessPhoneNumber;

  Map<String, dynamic> toMap() {
    return {
      'businessName': _businessName,
      'businessAddress': _businessAddress,
      'businessEmail': _businessEmail,
      'businessPhoneNumber': _businessPhoneNumber
    };
  }
}
