import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constance/colors.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/constance/styles.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/utilities/scan_bard_code.dart';
import '../../../../core/widgets/custom_Floating_button.dart';
import '../../../../core/widgets/custom_circular_progress.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/text_card.dart';
import '../../../../core/widgets/unit_widget.dart';
import '../../../domain/items/entity/item.dart';

final _formKey = GlobalKey<FormState>();

class NewItemScreen extends StatefulWidget {
  final Item? item;
  final ScreenMode mode;

  const NewItemScreen({super.key, this.item, required this.mode});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  late final TextEditingController _itemName;
  late final TextEditingController _description;
  late final TextEditingController _price;
  late final TextEditingController _quantity;
  late final TextEditingController _tax;
  late final TextEditingController _stock;
  late String _unit = 'pcs';
  late final int? _id;
  late String barCode = '00000000000000';
  bool loading = false;
  late ScreenMode mode;

  @override
  void initState() {
    _itemName = TextEditingController();
    _description = TextEditingController();
    _price = TextEditingController();
    _quantity = TextEditingController();
    _tax = TextEditingController();
    _stock = TextEditingController();
    mode = widget.mode;

    // check if the item is not null this mean that item was passed to the screen
    // so assign this item data to each TextField as a default data
    if (widget.item != null) {
      _id = widget.item!.id!;
      barCode = widget.item!.barCode!;
      _itemName.text = widget.item!.name;
      _description.text = widget.item!.description ?? '';
      _price.text = widget.item!.price.toString();
      _quantity.text = widget.item!.quantity.toString();
      _stock.text = widget.item!.stock.toString();
      _unit = widget.item!.unit.toString();
      _tax.text = widget.item!.tax.toString();
    }
    super.initState();
  }

  // create instance from the barCode class so we can call its function to scan the barfCode
  ScanBarCode scanner = ScanBarCode();

  // function for displaying the error dialog
  void displayErrorDialog(Object e) {
    showErrorDialog(context, 'Error', e.toString());
  }

  @override
  Widget build(BuildContext context) {
    void displaySnackBar(String msg) {
      snackBar(context, msg);
    }

    // clear all user input
    void clearUserInput() {
      _itemName.clear();
      _description.clear();
      _price.clear();
      _quantity.clear();
      _tax.clear();
      _unit = '';
      _stock.clear();
      barCode = 'Scan the bar Code';
    }

    // we generate a new item the we will submit to the database form the data that the use has inserted.
    Item generateNewItem() {
      // create instance from Item
      Item item = Item(
        barCode: barCode,
        name: _itemName.text,
        description: _description.text,
        price: double.parse(_price.text.trim()),
        quantity: double.parse(_quantity.text.trim()),
        tax: double.parse(_tax.text.trim()),
        unit: _unit,
        stock: double.parse(_stock.text.trim()),
      );
      return item;
    }

    // this function will update the loading state in one place
    void updateLoadingStata(bool value) {
      setState(() {
        loading = value;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Item'),
          leading: InkWell(
            onTap: () => context.pop(),
            child: Icon(Icons.close),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextCard(
                      bg: kTextInputBg1,
                      w: 340,
                      p: 14,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'barCode: $barCode',
                            style: kTextStyle2,
                          ),
                          InkWell(
                            onTap: () async {
                              String result = await scanner.scan(context);
                              setState(() {
                                barCode = result;
                              });
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      )),
                  CustomTextField(
                    readOnly: loading,
                    controller: _itemName,
                    keyType: kKeyTextType,
                    placeholder: 'Item name',
                    title: 'Name: ',
                    bg: kTextInputBg1,
                    validator: (name) =>
                        name!.length < 3 ? 'please Insert valid input' : null,
                    onErase: () => _itemName.clear(),
                  ),
                  CustomTextField(
                    readOnly: loading,
                    controller: _description,
                    title: 'Description: ',
                    keyType: kKeyTextType,
                    placeholder: 'Description',
                    bg: kTextInputBg1,
                    validator: (name) =>
                        name!.length < 3 ? 'please Insert valid input' : null,
                    onErase: () => _description.clear(),
                  ),
                  CustomTextField(
                    readOnly: loading,
                    controller: _price,
                    keyType: kKeyNumberType,
                    placeholder: 'Price',
                    title: 'Price: ',
                    bg: kTextInputBg1,
                    validator: (price) =>
                        price!.isEmpty ? 'please Insert valid input' : null,
                    onErase: () => _price.clear(),
                  ),
                  CustomTextField(
                    readOnly: loading,
                    controller: _quantity,
                    keyType: kKeyNumberType,
                    // initialValue: '1',
                    placeholder: 'Item quantity',
                    title: 'Quantity: ',
                    bg: kTextInputBg1,
                    validator: (quantity) =>
                        quantity!.isEmpty ? 'please Insert valid input' : null,
                    onErase: () => _quantity.clear(),
                  ),
                  CustomTextField(
                    readOnly: loading,
                    controller: _stock,
                    keyType: kKeyNumberType,
                    placeholder: 'stock',
                    title: 'stock: ',
                    bg: kTextInputBg1,
                    validator: (tax) =>
                        tax!.isEmpty ? 'please Insert valid input' : null,
                    onErase: () => _stock.clear(),
                  ),
                  UnitWidget(
                    unit: _unit,
                    onChange: (String selectedUnit) {
                      setState(() {
                        _unit = selectedUnit;
                      });
                    },
                  ),
                  // CustomTextField(
                  //   readOnly: loading,
                  //   controller: _unit,
                  //   keyType: kKeyTextType,
                  //   placeholder: 'unit',
                  //   title: 'unit: (piece, km...)',
                  //   bg: kTextInputBg1,
                  //   validator: (tax) =>
                  //       tax!.isEmpty ? 'please Insert valid input' : null,
                  //   onErase: () => _unit.clear(),
                  // ),
                  CustomTextField(
                    readOnly: loading,
                    controller: _tax,
                    keyType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    placeholder: 'Tax Percentage',
                    title: 'Tax %: ',
                    bg: kTextInputBg1,
                    validator: (tax) =>
                        tax!.isEmpty ? 'please Insert valid input' : null,
                    onErase: () => _tax.clear(),
                  ),
                  CustomTextButton(
                    onPressed: () async {
                      print('hello');
                      // check if the input is valid before submitting it
                      bool? valid = _formKey.currentState?.validate();
                      if (valid == true) {
                        Item newItem = generateNewItem();
                        try {
                          // set loading state to true when we are going to submit data
                          updateLoadingStata(true);

                          if (mode == ScreenMode.navigate) {
                            // submit the new item to the database
                            context
                                .read<ItemBloc>()
                                .add(AddItemEvent(item: newItem));
                            // after the submitting succeed remove all user input
                            displaySnackBar(
                                'the Item was created successfully');
                            // clear user input
                            clearUserInput();
                          } else if (mode == ScreenMode.update) {
                            // this for updating the item if the mode is not navigate it's update
                            try {
                              context.read<ItemBloc>().add(UpdateItemEvent(
                                    item: newItem,
                                    id: _id!,
                                  ));
                              displaySnackBar('item was updated successfully');
                            } catch (e) {
                              displayErrorDialog(e);
                            }
                          } else {
                            displayErrorDialog('check the mode you are using');
                          }
                          // after data was submitted ste loading to false
                          updateLoadingStata(false);
                        } catch (e) {
                          // after data was submitting failed we stop the loading and display the error dialog
                          updateLoadingStata(false);
                          displayErrorDialog(e);
                        }
                        // context.pop(item);
                      }
                    },
                    label: loading
                        ? CustomCircularProgress()
                        : Text(
                            widget.mode == ScreenMode.navigate
                                ? 'save'
                                : 'update',
                            style: kTextStyle2b,
                          ),
                    w: 120,
                    h: 50,
                    bg: Colors.green,
                    fg: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: CustomFloatingButton(
          onPressed: () async {
            String result = await scanner.scan(context);
            setState(() {
              barCode = result;
            });
          },
          child: Icon(
            Icons.barcode_reader,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
