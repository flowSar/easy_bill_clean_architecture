import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import '../model/client.dart';
import '../repository/client_repository.dart';

abstract interface class ClientUseCase {
  Future<Either<Failure, int>> addClient(Client client);

  Future<Either<Failure, int>> deleteClient(int id);

  Future<Either<Failure, List<Client>>> getClients();

  Future<Either<Failure, Client>> getClient(int id);

  Future<Either<Failure, int>> updateClient(Client client);
}

class ClientUseCaseImpl implements ClientUseCase {
  final ClientRepository clientRepository;

  ClientUseCaseImpl(this.clientRepository);

  @override
  Future<Either<Failure, int>> addClient(Client client) {
    return clientRepository.addClient(client);
  }

  @override
  Future<Either<Failure, int>> deleteClient(int id) {
    return clientRepository.deleteClient(id);
  }

  @override
  Future<Either<Failure, Client>> getClient(int id) {
    return clientRepository.getClient(id);
  }

  @override
  Future<Either<Failure, List<Client>>> getClients() {
    return clientRepository.getClients();
  }

  @override
  Future<Either<Failure, int>> updateClient(Client client) {
    return clientRepository.updateClient(client);
  }
}
