import '../../../domain/clients/model/client.dart';

class ClientModel extends Client {
  ClientModel({
    super.id,
    required super.fullName,
    super.email,
    super.address,
    super.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': super.fullName,
      'address': super.address,
      'email': super.email,
      'phoneNumber': super.phoneNumber,
    };
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      fullName: json['fullName'],
      address: json['address'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
    );
  }

  factory ClientModel.fromEntity(Client client) {
    return ClientModel(
      id: client.id,
      fullName: client.fullName,
      address: client.address,
      email: client.email,
      phoneNumber: client.phoneNumber,
    );
  }

// Map<String, dynamic> allToMap() {
//   return {
//     'id': id,
//     'fullName': fullName,
//     'address': address,
//     'email': email,
//     'phoneNumber': phoneNumber,
//   };
// }
}
