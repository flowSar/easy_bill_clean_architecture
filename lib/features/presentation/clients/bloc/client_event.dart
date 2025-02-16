import '../../../domain/clients/model/client.dart';

abstract class ClientEvent {}

class GetClientEvent extends ClientEvent {}

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
