import 'package:easy_bill_clean_architecture/features/domain/business_info/entity/business_info_entity.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_state.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../core/constance/colors.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/constance/styles.dart';
import '../../../../core/models/invoice.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/utilities/scan_bard_code.dart';
import '../../../../core/widgets/custom_Floating_button.dart';
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
  late String currency;
  DateTime now = DateTime.now();
  late String date;
  late final String invoiceId;
  final bool notEmpty = false;
  late BusinessInfo? businessInfo;

  @override
  void initState() {
    invoiceId = uuid.v4();
    loadBusinessInfo();
    // currency = context.read<SettingsProvider>().currency;
    currency = 'dh';
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
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              spacing: 8,
              children: [
                // check if the clients not selected display card that show that the client is not selected
                client != null
                    ? UserCard(
                        title: client!.fullName,
                        subTitle: client!.email!,
                        elevation: 2,
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
                        elevation: 2,
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
                // consumer for consuming the business info from the dataProviders
                BlocBuilder<BusinessInfoBloc, BusinessInfoState>(
                    builder: (context, state) {
                  if (state is BusinessInfoFailed) {
                    return SelectItemButton(
                      elevation: 2,
                      label: 'Business Info',
                      onPressed: () {
                        context.push('/businessScreen');
                      },
                    );
                  }
                  if (state is BusinessInfoLoading) {
                    return CustomCircularProgress(
                      strokeWidth: 2,
                      h: 35,
                      w: 35,
                    );
                  }
                  if (state is BusinessInfoLoaded) {
                    businessInfo = state.businessInfo;
                    return UserCard(
                      onPressed: () {
                        context.push('/businessScreen');
                      },
                      elevation: 2,
                      title: businessInfo!.businessName,
                      subTitle: businessInfo!.businessEmail!,
                    );
                  }
                  return Text('loading...');
                }),
                Expanded(
                  child: selectedItems.isNotEmpty
                      ? ListView.builder(
                          itemCount: selectedItems.length,
                          itemBuilder: (context, index) {
                            return SelectedItemCard(
                              onEdite: () {},
                              onDelete: () {
                                setState(() {
                                  selectedItems.removeAt(index);
                                });
                              },
                              bg: greyLight,
                              name: selectedItems[index].name,
                              barCode: selectedItems[index].barCode!,
                              quantity: selectedItems[index].quantity!,
                              price: selectedItems[index].price,
                              tax: selectedItems[index].tax!,
                            );
                          })
                      : Empty(
                          title: 'No Item was added',
                          subTitle: 'no item msg',
                        ),
                ),

                InkWell(
                  onTap: () {
                    // navigate the items screen and select item
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
                        // initialize the barcode
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
                  child: DottedBorder(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: greyLight,
                      padding: EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Row(
                        spacing: 4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add item',
                            style: kTextStyle2b.copyWith(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Icon(
                            Icons.add,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: greyLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: Text(
                    'Total: $billTotal $currency',
                    style: kTextStyle2b.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: greyLight,
          padding: EdgeInsets.all(0),
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomFloatingButton(
                onPressed: () async {
                  if (selectedItems.isNotEmpty) {
                    if (client != null) {
                      try {
                        fillDataIntoRows(invoiceId, billTotal);

                        // confirm saving invoice by displaying a dialog
                        displaySaveInvoiceOption(context, (answer) async {
                          // if the answer is true we save the invoice
                          if (answer) {
                            // insert data to database
                            context
                                .read<InvoiceBloc>()
                                .add(AddInvoicesEvent(invoice, invoiceItems));

                            // display snack abr
                            displaySnackBar(
                                'the invoice was created successfully');

                            setState(
                              () {
                                invoiceItems = [];
                                selectedItems = [];
                              },
                            );
                          }
                        });
                      } catch (e) {
                        errorDialog(e);
                      }
                    } else {
                      showErrorDialog(
                          context, "Error ", 'please select the client');
                    }
                  } else {
                    showErrorDialog(
                        context, "Error ", 'please select new Item');
                  }
                },
                w: 90,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.save,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              CustomFloatingButton(
                onPressed: () async {
                  try {
                    // scan bar code
                    String result = await scanner.scan(context);
                    barCode = result;
                    // check if the barcode was scanned
                    if (barCode != '-1') {
                      // check if the item with this barCode exist in database
                      Item? item = filterByBarCode(barCode.trim());
                      // check if the item was found and not null
                      if (item != null) {
                        // if the item exist open the bottomSheetModal
                        Item? newItem = await displayBottomModal(item);

                        if (newItem != null) {
                          setState(() {
                            selectedItems.add(newItem);
                          });
                        }
                      } else {
                        // Navigate to add new item screen
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
                        // if the item with the bar code that we scanned not exist in database we automatically
                        // navigate the use to the newItemScreen so he can add this new Item
                        navigateTo(newItem);
                        // context.push('/newItemScreen', extra: newItem);
                      }
                    }
                  } catch (e) {
                    displayDialogError(e);
                  }
                },
                w: 90,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Scan',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.barcode_reader,
                        color: Colors.white,
                      )
                    ],
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
