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

import '../../../../core/constance/colors.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/widgets/client_card.dart';
import '../../../../core/widgets/custom_Floating_button.dart';
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
    // SettingsProvider language = context.watch<SettingsProvider>();

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Clients'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            CustomTextField(
              controller: _searchKeyWord,
              bg: kTextInputBg1,
              placeholder: 'Search client name',
              title: 'Client Name',
              icon: Icon(Icons.search),
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
            BlocConsumer<ClientBloc, ClientState>(
              listener: (context, state) {
                if (state is ClientAdded) {
                  context.read<ClientBloc>().add(GetClientsEvent());
                }
                if (state is ClientDeleted) {
                  context.read<ClientBloc>().add(GetClientsEvent());
                }
                if (state is ClientUpdated) {
                  context.read<ClientBloc>().add(GetClientsEvent());
                }
              },
              builder: (context, state) {
                if (state is ClientLoading) {
                  return CustomCircularProgress(
                    h: 100,
                    w: 100,
                    strokeWidth: 6,
                  );
                }

                if (state is ClientFailed) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state is ClientDeleteFailed) {
                  showErrorDialog(context, 'Delete Client',
                      'delete client failed: ${state.error}');
                }
                if (state is LoadClientsSuccess) {
                  clients = state.clients;
                }
                return Expanded(
                    child: clients.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: loadClientsData,
                            child: ListView.builder(
                              padding: EdgeInsets.only(bottom: height * 0.085),
                              itemCount: clients.length,
                              itemBuilder: (context, index) {
                                return ClientCard(
                                  title: clients[index].fullName,
                                  subTitle: clients[index].email!,
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
                                    context.read<ClientBloc>().add(
                                        DeleteClientEvent(clients[index].id!));
                                  },
                                  onTap: () {
                                    print('select.......');
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
                          )
                        : SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.7,
                              child: Empty(
                                title: 'No clients found',
                                subTitle:
                                    'tap a Button Below to Create New client',
                                btnLabel: 'add New client',
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
                            ),
                          ));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingButton(
          w: 130,
          onPressed: () {
            context
                .push(
              '/newClientScreen',
              extra: ClientScreenParams(
                client: null,
                mode: ScreenMode.navigate,
              ),
            )
                .then((newClient) {
              if (newClient != null) {
                // Client client = newClient as Client;
                // setState(() {
                //   clients.add(client);
                // });
              }
            });
          },
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              Text(
                'New Client',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
