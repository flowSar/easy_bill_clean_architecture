import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import '../model/client.dart';
import '../repository/client_repository.dart';

class GetClientsUseCase {
  final ClientRepository clientRepository;

  GetClientsUseCase(this.clientRepository);

  Future<Either<Failure, List<Client>>> call() async {
    return clientRepository.getClients();
  }
}
