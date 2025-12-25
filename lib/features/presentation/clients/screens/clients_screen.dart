import 'package:easy_bill_clean_architecture/core/utilities/functions.dart';
import 'package:easy_bill_clean_architecture/core/widgets/error_dialog.dart';
import 'package:easy_bill_clean_architecture/features/data/clients/models/client_model.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/model/client.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constance/g_constants.dart';
import '../../../../core/widgets/client_card.dart';
import '../../../../core/widgets/custom_circular_progress.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/empty.dart';

class ClientsScreen extends StatefulWidget {
  final ScreenMode mode;

  const ClientsScreen({super.key, required this.mode});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  late final TextEditingController _searchKeyWord;
  late List<Client> clients = [];

  @override
  void initState() {
    _searchKeyWord = TextEditingController();
    loadClientsData();
    super.initState();
  }

  @override
  void dispose() {
    _searchKeyWord.dispose();
    super.dispose();
  }

  Future<void> loadClientsData() async {
    try {
      // load client from database
      context.read<ClientBloc>().add(GetClientsEvent());
    } catch (e) {
      showErrorDialog(context, 'loading Clients', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Clients',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: CustomTextField(
              controller: _searchKeyWord,
              placeholder: 'Search client name',
              title: 'Client',
              icon: Icon(Icons.search_rounded, color: theme.primaryColor),
              onChanged: (keyWord) {
                context.read<ClientBloc>().add(FilterClientEvent(keyWord));
              },
              onErase: () {
                context.read<ClientBloc>().add(FilterClientEvent(''));
                setState(() {
                  _searchKeyWord.text = '';
                });
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<ClientBloc, ClientState>(
              listener: (context, state) {
                if (state is ClientAdded ||
                    state is ClientDeleted ||
                    state is ClientUpdated) {
                  context.read<ClientBloc>().add(GetClientsEvent());
                }
                if (state is ClientDeleteFailed) {
                  showErrorDialog(context, 'Delete Client',
                      'delete client failed: ${state.error}');
                }
              },
              builder: (context, state) {
                if (state is ClientLoading) {
                  return const Center(child: CustomCircularProgress());
                }

                if (state is ClientFailed) {
                  return Center(child: Text(state.error));
                }

                if (state is LoadClientsSuccess) {
                  clients = state.clients;
                }

                if (clients.isEmpty) {
                  return Center(
                    child: Empty(
                      title: 'No clients found',
                      subTitle: 'Add your first client to get started',
                      btnLabel: 'Add New Client',
                      onPressed: () {
                        context.push(
                          '/newClientScreen',
                          extra: ClientScreenParams(
                            client: null,
                            mode: ScreenMode.navigate,
                          ),
                        );
                      },
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: loadClientsData,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80, top: 4),
                    itemCount: clients.length,
                    itemBuilder: (context, index) {
                      return ClientCard(
                        title: clients[index].fullName,
                        subTitle: clients[index].email ?? 'No email available',
                        onEdite: () {
                          context.push(
                            '/newClientScreen',
                            extra: ClientScreenParams(
                              client: clients[index],
                              mode: ScreenMode.update,
                            ),
                          );
                        },
                        onDelete: () {
                          context
                              .read<ClientBloc>()
                              .add(DeleteClientEvent(clients[index].id!));
                        },
                        onTap: () {
                          if (widget.mode == ScreenMode.navigate ||
                              widget.mode == ScreenMode.update) {
                            context.push(
                              '/newClientScreen',
                              extra: ClientScreenParams(
                                client: clients[index],
                                mode: ScreenMode.update,
                              ),
                            );
                          } else {
                            context.pop(clients[index]);
                          }
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(
            '/newClientScreen',
            extra: ClientScreenParams(
              client: null,
              mode: ScreenMode.navigate,
            ),
          );
        },
        label: const Text('New Client',
            style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_rounded),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
