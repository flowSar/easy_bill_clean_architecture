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
    on<UpdateClientEvent>(_updateClient);
    on<DeleteClientEvent>(_deleteClient);
    on<FilterClientEvent>(_filterItems);
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
      emit(ClientAdded());
    });
  }

  Future<void> _getClient(ClientEvent event, Emitter<ClientState> emit) async {
    try {
      if (event is GetClientEvent) {
        final id = event.id;
        final result = await clientUseCase.getClient(id);
        result.fold((failure) {
          return emit(ClientUpdateFailed(failure.error));
        }, (res) {
          emit(LoadClientSuccess(res));
        });
      }
    } catch (e) {
      emit(ClientFailed(e.toString()));
    }
  }

  Future<void> _updateClient(
      ClientEvent event, Emitter<ClientState> emit) async {
    emit(ClientLoading());
    Client client = (event as UpdateClientEvent).client;
    final result = await clientUseCase.updateClient(client);
    result.fold((failure) {
      emit(ClientUpdateFailed(failure.toString()));
    }, (clients) {
      emit(ClientUpdated());
    });
  }

  Future<void> _deleteClient(
      ClientEvent event, Emitter<ClientState> emit) async {
    emit(ClientLoading());
    int id = (event as DeleteClientEvent).id;
    final result = await clientUseCase.deleteClient(id);
    result.fold((failure) {
      emit(ClientDeleteFailed(failure.toString()));
    }, (clients) {
      emit(ClientDeleted());
    });
  }

  Future<void> _filterItems(
      ClientEvent event, Emitter<ClientState> emit) async {
    try {
      emit(ClientLoading());

      String keyWord = (event as FilterClientEvent).fullName;
      final result = await clientUseCase.getClients();
      result.fold((failure) {
        emit(ClientFailed(failure.error));
      }, (items) {
        emit(
          LoadClientsSuccess(
            items.where((item) => item.fullName.contains(keyWord)).toList(),
          ),
        );
      });
    } catch (e) {
      emit(ClientFailed(e.toString()));
    }
  }
}
