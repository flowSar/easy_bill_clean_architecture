import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import '../repository/client_repository.dart';

class DeleteClientUseCase {
  final ClientRepository clientRepository;

  DeleteClientUseCase(this.clientRepository);

  Future<Either<Failure, int>> call(int id) async {
    return clientRepository.deleteClient(id);
  }
}
