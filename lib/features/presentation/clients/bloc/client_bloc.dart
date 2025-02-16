import 'package:easy_bill_clean_architecture/features/domain/clients/use_cases/add_client_use_case.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/use_cases/get_clients_use_case.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/clients/model/client.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final GetClientsUseCase getClientsUseCase;
  final AddClientUseCase addClientUseCase;

  ClientBloc({
    required this.getClientsUseCase,
    required this.addClientUseCase,
  }) : super(ClientInitial()) {
    on<GetClientEvent>(_getClients);
    on<AddClientEvent>(_addClient);
  }

  void _getClients(ClientEvent event, Emitter<ClientState> emit) async {
    emit(ClientLoading());
    final result = await getClientsUseCase.call();

    result.fold((failure) {
      emit(ClientFailed(failure.toString()));
    }, (clients) {
      print('clients: $result');
      emit(LoadClientsSuccess(clients));
    });
  }

  void _addClient(ClientEvent event, Emitter<ClientState> emit) async {
    emit(ClientLoading());
    Client client = (event as AddClientEvent).client;
    final result = await addClientUseCase.call(client);
    result.fold((failure) {
      emit(ClientFailed(failure.toString()));
    }, (clients) {
      emit(AddClientsSuccess());
    });
  }
}
