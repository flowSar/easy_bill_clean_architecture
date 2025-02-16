class Client {
  final int? id;
  final String fullName;
  final String? address;
  final String? email;
  final String? phoneNumber;

  Client(
      {this.id,
      required this.fullName,
      this.address,
      this.email,
      this.phoneNumber});
}
