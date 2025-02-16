import '../../../domain/clients/model/client.dart';

abstract class ClientState {}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class LoadClientsSuccess extends ClientState {
  final List<Client> clients;

  LoadClientsSuccess(this.clients);
}

class AddClientsSuccess extends ClientState {}

class ClientFailed extends ClientState {
  final String error;

  ClientFailed(this.error);
}
