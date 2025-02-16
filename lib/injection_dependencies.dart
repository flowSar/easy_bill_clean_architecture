import 'package:easy_bill_clean_architecture/core/use_case/item_use_case.dart';
import 'package:easy_bill_clean_architecture/features/data/business_info/data_source/business_local_data_source.dart';
import 'package:easy_bill_clean_architecture/features/data/business_info/repository/business_info_repository_impl.dart';
import 'package:easy_bill_clean_architecture/features/data/clients/data_source/client_local_data_source.dart';
import 'package:easy_bill_clean_architecture/features/data/clients/repository/client_repository_impl.dart';
import 'package:easy_bill_clean_architecture/features/data/items/data_source/item_local_data_source.dart';
import 'package:easy_bill_clean_architecture/features/data/items/repository/item_repository_impl.dart';
import 'package:easy_bill_clean_architecture/features/domain/business_info/repository/business_info_repository.dart';
import 'package:easy_bill_clean_architecture/features/domain/business_info/user_cases/business_info_use_case_impl.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/repository/client_repository.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/use_cases/add_client_use_case.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/use_cases/get_clients_use_case.dart';
import 'package:easy_bill_clean_architecture/features/domain/items/item_use_cases/item_use_case_impl.dart';
import 'package:easy_bill_clean_architecture/features/domain/items/repository/item_repository.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  // register the items bloc
  sl.registerSingleton<ItemLocalDataSource>(
    ItemLocalDataSourceImpl(),
  );
  sl.registerSingleton<ItemRepository>(
    ItemRepositoryImpl(
      sl<ItemLocalDataSource>(),
    ),
  );
  sl.registerSingleton<ItemUseCases>(
    ItemUseCaseImpl(
      sl<ItemRepository>(),
    ),
  );
  sl.registerFactory<ItemBloc>(
    () => ItemBloc(
      itemUseCases: sl<ItemUseCases>(),
    ),
  );

  // register the client bloc
  sl.registerSingleton<ClientLocalDataSource>(
    ClientLocalDataSource(),
  );

  sl.registerSingleton<ClientRepository>(
    ClientRepositoryImpl(
      sl<ClientLocalDataSource>(),
    ),
  );

  sl.registerSingleton<GetClientsUseCase>(
    GetClientsUseCase(
      sl<ClientRepository>(),
    ),
  );
  sl.registerSingleton<AddClientUseCase>(
    AddClientUseCase(
      sl<ClientRepository>(),
    ),
  );
  sl.registerFactory<ClientBloc>(
    () => ClientBloc(
      getClientsUseCase: sl<GetClientsUseCase>(),
      addClientUseCase: sl<AddClientUseCase>(),
    ),
  );

  // register BusinessInfoBloc
  sl.registerSingleton<BusinessInfoLocalDataSource>(
    BusinessInfoLocalDataSourceImpl(),
  );

  sl.registerSingleton<BusinessInfoRepository>(
    BusinessInfoRepositoryImpl(
      sl<BusinessInfoLocalDataSource>(),
    ),
  );

  sl.registerSingleton<BusinessInfoUseCase>(
    BusinessInfoUseCaseImpl(
      repository: sl<BusinessInfoRepository>(),
    ),
  );

  sl.registerFactory<BusinessInfoBloc>(
    () => BusinessInfoBloc(
      sl<BusinessInfoUseCase>(),
    ),
  );
}
