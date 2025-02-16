import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../model/client.dart';

abstract interface class ClientRepository {
  Future<Either<Failure, int>> addClient(Client client);

  Future<Either<Failure, List<Client>>> getClients();

  Future<Either<Failure, int>> deleteClient(int id);

  Future<Either<Failure, int>> updateClient(Client client);
}
