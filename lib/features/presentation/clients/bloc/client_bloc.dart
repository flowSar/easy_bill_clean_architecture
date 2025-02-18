import 'package:easy_bill_clean_architecture/features/domain/clients/use_cases/client_use_case.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/clients/model/client.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientUseCase clientUseCase;

  ClientBloc({
    required this.clientUseCase,
  }) : super(ClientInitial()) {
    on<GetClientsEvent>(_getClients);
    on<AddClientEvent>(_addClient);
    on<GetClientEvent>(_getClient);
  }

  Future<void> _getClients(ClientEvent event, Emitter<ClientState> emit) async {
    emit(ClientLoading());
    final result = await clientUseCase.getClients();

    result.fold((failure) {
      emit(ClientFailed(failure.toString()));
    }, (clients) {
      print('clients: $result');
      emit(LoadClientsSuccess(clients));
    });
  }

  Future<void> _addClient(ClientEvent event, Emitter<ClientState> emit) async {
    emit(ClientLoading());
    Client client = (event as AddClientEvent).client;
    final result = await clientUseCase.addClient(client);
    result.fold((failure) {
      emit(ClientFailed(failure.toString()));
    }, (clients) {
      emit(AddClientsSuccess());
    });
  }

  Future<void> _getClient(ClientEvent event, Emitter<ClientState> emit) async {
    try {
      if (event is GetClientEvent) {
        final id = event.id;
        final result = await clientUseCase.getClient(id);
        result.fold((failure) {
          return emit(ClientFailed(failure.error));
        }, (res) {
          emit(LoadClientSuccess(res));
        });
      }
    } catch (e) {
      emit(ClientFailed(e.toString()));
    }
  }
}
