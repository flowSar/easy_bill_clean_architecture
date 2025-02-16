import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import '../model/client.dart';
import '../repository/client_repository.dart';

class UpdateClientUseCase {
  final ClientRepository clientRepository;

  UpdateClientUseCase(this.clientRepository);

  Future<Either<Failure, int>> call(Client client) async {
    return clientRepository.updateClient(client);
  }
}
