import 'package:easy_bill_clean_architecture/features/domain/business_info/entity/business_info_entity.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_state.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_state.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../../../../core/constance/g_constants.dart';

import '../../../../core/models/invoice.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/utilities/scan_bard_code.dart';

import '../../../../core/widgets/custom_circular_progress.dart';
import '../../../../core/widgets/custom_modal_Bottom_sheet.dart';
import '../../../../core/widgets/empty.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/select_item_button.dart';
import '../../../../core/widgets/selected_item_card.dart';
import '../../../../core/widgets/user_card.dart';
import '../../../domain/clients/model/client.dart';
import '../../../domain/invoices/entities/invoice.dart';
import '../../../domain/items/entity/item.dart';
import '../../items/screens/new_item_screen.dart';

var uuid = Uuid();

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  ScanBarCode scanner = ScanBarCode();
  late String barCode;
  late String selectedClient = 'Clients';
  bool loading = false;
  double billTotal = 0.0;
  List<Item> selectedItems = [];
  Client? client;
  List<InvoiceItem> invoiceItems = [];
  late Invoice invoice;
  DateTime now = DateTime.now();
  late String date;
  late final String invoiceId;
  final bool notEmpty = false;
  late BusinessInfo? businessInfo;

  @override
  void initState() {
    invoiceId = uuid.v4();
    loadBusinessInfo();

    date = DateFormat('dd/MM/yyyy').format(now);
    super.initState();
  }

  Future loadBusinessInfo() async {
    try {
      context.read<BusinessInfoBloc>().add(GetBusinessInfoEvent());
    } catch (e) {
      showErrorDialog(context, 'businessInfo', 'business info loading failed');
    }
  }

  // this function will call the bottomSheetModal and pass the item data to it
  Future<Item?> displayBottomModal(Item item) async {
    Item? newItem = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          CustomModalBottomSheet(barCode: barCode, item: item),
    );
    return newItem;
  }

  @override
  Widget build(BuildContext context) {
    // SettingsProvider language = context.watch<SettingsProvider>();

    // we filter all the item by barcode so we can extract the object we need
    Item? filterByBarCode(String? barCode) {
      List<Item> items = [];
      for (var item in items) {
        if (item.barCode == barCode) {
          return item;
        }
      }
      return null;
    }

    // we calculate the bill total by iterating over the list of items and sum their total
    double getBillTotal() {
      double total = 0.0;
      double subTotal = 0.0;
      for (var item in selectedItems) {
        double? tax = item.tax;
        subTotal = (item.quantity! * item.price);
        total += (subTotal + (subTotal * tax!) / 100) * 100;
      }
      return total / 100;
    }

    late double billTotal = getBillTotal();

    // we fill data into a list of billRows so we can add this list to the bill
    // we fill the object( from Bill) that will cary all the data that we will send to the base
    void fillDataIntoRows(String billId, billTotal) {
      invoiceItems = [];
      int index = 0;
      for (var item in selectedItems) {
        double tax = item.tax!;
        double subtotal = item.price * item.quantity!;
        double total = subtotal + (subtotal * tax) / 100;
        invoiceItems.add(InvoiceItem(
          name: item.name,
          quantity: item.quantity!,
          price: item.price,
          total: total,
          tax: item.tax!,
          unit: item.unit!,
          invoiceId: invoiceId,
        ));
        index++;
      }
      invoice = Invoice(
        id: invoiceId,
        clientId: client!.id!,
        date: date,
        total: billTotal,
        invoiceNumber: 'NV00',
        rest: 0.0,
        pay: 0.0,
        items: invoiceItems,
      );
    }

    // this function is calling the custom widget for displaying the error
    void errorDialog(Object e) {
      showErrorDialog(context, "Error ", 'error: $e');
    }

    // function for navigating to NewItemScreen
    void navigateTo(Item newItem) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewItemScreen(
            item: newItem,
            mode: ScreenMode.navigate,
          ),
        ),
      );
    }

    // display error dialog
    void displayDialogError(Object e) {
      showErrorDialog(
        context,
        'Error',
        e.toString(),
      );
    }

    // this function will can the function that will create a snake bar,
    void displaySnackBar(String msg) {
      snackBar(context, msg);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocListener<InvoiceBloc, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceFailed) {
              showErrorDialog(context, 'insert invoice', state.error);
            }
            if (state is InvoiceSuccess) {
              snackBar(context, 'invoice insert success');
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              spacing: 4,
              children: [
                client != null
                    ? UserCard(
                        title: client!.fullName,
                        subTitle: client!.email ?? 'No email',
                        elevation: 0,
                        onPressed: () {
                          context
                              .push(
                            '/clientScreen',
                            extra: ClientScreenParams(
                              client: null,
                              mode: ScreenMode.select,
                            ),
                          )
                              .then((newClient) {
                            if (newClient != null) {
                              setState(() {
                                client = newClient as Client;
                              });
                            }
                          });
                        },
                      )
                    : SelectItemButton(
                        elevation: 0,
                        label: 'Select Client',
                        onPressed: () {
                          context
                              .push('/clientScreen',
                                  extra: ClientScreenParams(
                                    client: null,
                                    mode: ScreenMode.select,
                                  ))
                              .then((newClient) {
                            if (newClient != null) {
                              setState(() {
                                client = newClient as Client;
                              });
                            }
                          });
                        },
                      ),
                BlocBuilder<BusinessInfoBloc, BusinessInfoState>(
                    builder: (context, state) {
                  if (state is BusinessInfoFailed) {
                    return SelectItemButton(
                      elevation: 0,
                      label: 'Business Info',
                      onPressed: () {
                        context.push('/businessScreen');
                      },
                    );
                  }
                  if (state is BusinessInfoLoading) {
                    return const SizedBox(
                      height: 40,
                      child: Center(
                        child: CustomCircularProgress(
                          strokeWidth: 2,
                          h: 24,
                          w: 24,
                        ),
                      ),
                    );
                  }
                  if (state is BusinessInfoLoaded) {
                    businessInfo = state.businessInfo;
                    return UserCard(
                      onPressed: () {
                        context.push('/businessScreen');
                      },
                      elevation: 0,
                      title: businessInfo!.businessName,
                      subTitle: businessInfo!.businessEmail ?? 'No email',
                    );
                  }
                  return const SizedBox.shrink();
                }),
                const Divider(height: 16),
                Expanded(
                  child: selectedItems.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: selectedItems.length,
                          itemBuilder: (context, index) {
                            return SelectedItemCard(
                              onEdite: () {},
                              onDelete: () {
                                setState(() {
                                  selectedItems.removeAt(index);
                                });
                              },
                              bg: Theme.of(context).cardColor,
                              name: selectedItems[index].name,
                              barCode: selectedItems[index].barCode!,
                              quantity: selectedItems[index].quantity!,
                              price: selectedItems[index].price,
                              tax: selectedItems[index].tax!,
                            );
                          })
                      : const Center(
                          child: Empty(
                            title: 'Invoice is empty',
                            subTitle: 'Add items below',
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextButton.icon(
                    onPressed: () {
                      context
                          .push(
                        '/itemsScreen',
                        extra: ItemScreenParams(
                          item: null,
                          mode: ScreenMode.select,
                        ),
                      )
                          .then((selectedItem) async {
                        if (selectedItem != null) {
                          Item item = selectedItem as Item;
                          barCode = item.barCode!;
                          Item? newItem = await displayBottomModal(item);

                          if (newItem != null) {
                            setState(() {
                              selectedItems.add(newItem);
                            });
                          }
                        }
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline_rounded),
                    label: const Text('ADD NEW ITEM',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      minimumSize: const Size(double.infinity, 44),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                      Theme.of(context).primaryColor.red,
                      Theme.of(context).primaryColor.green,
                      Theme.of(context).primaryColor.blue,
                      0.1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: BlocBuilder<SettingsBloc, SettingsState>(
                    builder: (context, state) {
                      String currency = state.currency ?? '\$';
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grand Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            '$billTotal $currency',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: isDark
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (selectedItems.isNotEmpty) {
                      if (client != null) {
                        try {
                          fillDataIntoRows(invoiceId, billTotal);
                          displaySaveInvoiceOption(context, (answer) async {
                            if (answer) {
                              context
                                  .read<InvoiceBloc>()
                                  .add(AddInvoicesEvent(invoice, invoiceItems));
                              displaySnackBar('Invoice created successfully');
                              setState(() {
                                invoiceItems = [];
                                selectedItems = [];
                              });
                            }
                          });
                        } catch (e) {
                          errorDialog(e);
                        }
                      } else {
                        showErrorDialog(
                            context, "Error", 'Please select a client');
                      }
                    } else {
                      showErrorDialog(context, "Error", 'Invoice is empty');
                    }
                  },
                  icon: const Icon(Icons.save_rounded, color: Colors.white),
                  label: const Text('SAVE',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    minimumSize: const Size(0, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    try {
                      String result = await scanner.scan(context);
                      barCode = result;
                      if (barCode != '-1') {
                        Item? item = filterByBarCode(barCode.trim());
                        if (item != null) {
                          Item? newItem = await displayBottomModal(item);
                          if (newItem != null) {
                            setState(() {
                              selectedItems.add(newItem);
                            });
                          }
                        } else {
                          Item newItem = Item(
                            barCode: barCode,
                            name: '',
                            price: 0,
                            quantity: 0,
                            tax: 0.0,
                            description: null,
                            unit: null,
                            stock: null,
                          );
                          navigateTo(newItem);
                        }
                      }
                    } catch (e) {
                      displayDialogError(e);
                    }
                  },
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  label: const Text('SCAN',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue.shade700,
                    side: BorderSide(color: Colors.blue.shade700),
                    minimumSize: const Size(0, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
