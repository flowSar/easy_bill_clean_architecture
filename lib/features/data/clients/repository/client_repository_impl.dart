import 'package:dartz/dartz.dart';
import 'package:easy_bill_clean_architecture/core/error/failure.dart';
import 'package:easy_bill_clean_architecture/features/data/clients/models/client_model.dart';

import '../../../domain/clients/model/client.dart';
import '../../../domain/clients/repository/client_repository.dart';
import '../data_source/client_local_data_source.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientLocalDataSource clientLocalDataSource;

  ClientRepositoryImpl(this.clientLocalDataSource);

  @override
  Future<Either<Failure, int>> addClient(Client client) async {
    try {
      final result =
          await clientLocalDataSource.addClient(ClientModel.fromEntity(client));
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Client>>> getClients() async {
    try {
      final result = await clientLocalDataSource.getClients();
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteClient(int id) async {
    try {
      final result = await clientLocalDataSource.deleteClient(id);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> updateClient(Client client) async {
    try {
      final result = await clientLocalDataSource.updateClient(client);
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Client>> getClient(int id) async {
    try {
      final client = await clientLocalDataSource.getClient(id);
      return Right(client);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
