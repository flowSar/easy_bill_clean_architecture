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
      final result = await clientLocalDataSource.getClient();
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> deleteClient(int id) {
    // TODO: implement deleteClient
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, int>> updateClient(Client client) {
    // TODO: implement updateClient
    throw UnimplementedError();
  }
}
