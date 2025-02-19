import '../../../domain/clients/model/client.dart';

abstract class ClientEvent {}

class GetClientsEvent extends ClientEvent {}

class GetClientEvent extends ClientEvent {
  final int id;

  GetClientEvent(this.id);
}

class AddClientEvent extends ClientEvent {
  final Client client;

  AddClientEvent(this.client);
}

class DeleteClientEvent extends ClientEvent {
  final int id;

  DeleteClientEvent(this.id);
}

class UpdateClientEvent extends ClientEvent {
  final Client client;

  UpdateClientEvent(this.client);
}

class FilterClientEvent extends ClientEvent {
  final String fullName;

  FilterClientEvent(this.fullName);
}
