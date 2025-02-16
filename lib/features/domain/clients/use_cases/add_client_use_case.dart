import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import '../model/client.dart';
import '../repository/client_repository.dart';

class AddClientUseCase {
  final ClientRepository clientRepository;

  AddClientUseCase(this.clientRepository);

  Future<Either<Failure, int>> call(Client client) async {
    return clientRepository.addClient(client);
  }
}
