class BusinessInfo {
  final int? id;
  final String businessName;
  final String? businessAddress;
  final String? businessEmail;
  final String? businessPhoneNumber;

  BusinessInfo({
    this.id,
    required this.businessName,
    this.businessAddress,
    this.businessEmail,
    this.businessPhoneNumber,
  });
}
