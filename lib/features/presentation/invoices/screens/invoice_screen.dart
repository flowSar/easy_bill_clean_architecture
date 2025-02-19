import 'package:easy_bill_clean_architecture/core/models/invoice.dart';
import 'package:easy_bill_clean_architecture/core/utilities/functions.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/model/client.dart';
import 'package:easy_bill_clean_architecture/features/domain/invoices/entities/invoice.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/bill_card.dart';
import '../../../../core/widgets/custom_circular_progress.dart';
import '../../../../core/widgets/empty.dart';
import '../../clients/bloc/client_state.dart';
import '../../settings/bloc/settings_bloc.dart';
import '../../settings/bloc/settings_event.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool loading = false;
  late bool isSearching = false;
  late TextEditingController searchKeyword;
  late List<GeneralInvoice> generalInvoices = [];
  late List<Client> clients = [];

  @override
  void initState() {
    loadInvoices();
    searchKeyword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchKeyword.dispose();
    super.dispose();
  }

  // load all bills from database
  Future loadInvoices() async {
    try {
      // set loading state to true when this function called

      // start loading data from database
      // await context.read<DataProvider>().loadInvoices();
      // set loading to false data after data loading finished
      // load invoices
      context.read<ClientBloc>().add(GetClientsEvent());
      context.read<InvoiceBloc>().add(GetInvoicesEvent());

      // load invoices
    } catch (e) {
      print('error|: ${e.toString()}');
      // set loading to false if loading failed and display the error
    }
  }

  @override
  Widget build(BuildContext context) {
    // SettingsProvider language = context.watch<SettingsProvider>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Invoices'),
        actions: [
          // if the use click on the search icon we open the search bar
          isSearching
              ? Row(
                  spacing: 14,
                  children: [
                    InkWell(
                      onTap: () {
                        searchKeyword.clear();
                        loadInvoices();
                        setState(() {
                          // set the searching state to false to hide the search bar
                          isSearching = false;
                        });
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 260,
                      child: TextField(
                        controller: searchKeyword,
                        decoration: InputDecoration(
                          hintText: 'Search (client name)',
                          border: InputBorder.none,
                        ),
                        onChanged: (keyWord) {
                          // call filter function with the isd of the clients that their name continue the keyword
                          context.read<InvoiceBloc>().add(FilterInvoicesEvent(
                              ids: getClientsId(clients, keyWord)));
                        },
                      ),
                    ),
                  ],
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.filter_alt,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocConsumer<InvoiceBloc, InvoiceState>(
            listener: (context, state) {},
            builder: (context, state) {
              List<Invoice> invoices = [];
              // each time the page get rebuild initialize the invoice to it get accumulated
              generalInvoices = [];

              if (state is InvoiceFailed) {
                return Center(child: Text(state.error));
              }

              if (state is InvoiceLoading) {
                return CustomCircularProgress(
                  w: 120,
                  h: 120,
                  strokeWidth: 4,
                );
              }
              // get all client
              final clientBlocState = context.read<ClientBloc>().state;
              if (clientBlocState is LoadClientsSuccess) {
                clients = clientBlocState.clients;
              }
              if (state is InvoicesLoaded) {
                invoices = state.invoices;
                for (final invoice in invoices) {
                  if (clients.isNotEmpty) {
                    generalInvoices.add(generateGeneralInvoice(
                        invoice, getClientById(clients, invoice.clientId)));
                  }
                }
              }
              return generalInvoices.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: generalInvoices.length,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.push('/previewBillScreen',
                                  extra: generalInvoices[index]);
                            },
                            child: BillCard(
                              client: generalInvoices[index].clientName,
                              date: generalInvoices[index].billDate,
                              total: generalInvoices[index].total.toString(),
                              billNumber: formatNumber(index + 1),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: isSearching
                            ? Text('No invoice Was found try another key word')
                            : Empty(
                                title: 'No invoice Was found', subTitle: ''),
                      ),
                    );
            },
          )
          // if the bills 1= []display bills
        ],
      ),
    ));
  }
}
