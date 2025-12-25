import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/utilities/scan_bard_code.dart';
import '../../../../core/widgets/custom_circular_progress.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/unit_widget.dart';
import '../../../domain/items/entity/item.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  @override
  void dispose() {
    _itemName.dispose();
    _description.dispose();
    _price.dispose();
    _quantity.dispose();
    _tax.dispose();
    _stock.dispose();
    super.dispose();
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
        id: _id,
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

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mode == ScreenMode.navigate ? 'New Item' : 'Edit Item',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Barcode Section
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color.fromRGBO(255, 255, 255, 0.05)
                        : const Color.fromRGBO(0, 0, 0, 0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? const Color.fromRGBO(255, 255, 255, 0.1)
                          : const Color.fromRGBO(0, 0, 0, 0.05),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Barcode',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? const Color.fromRGBO(255, 255, 255, 0.5)
                                    : const Color.fromRGBO(0, 0, 0, 0.5),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              barCode,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton.filledTonal(
                        onPressed: () async {
                          String result = await scanner.scan(context);
                          setState(() {
                            barCode = result;
                          });
                        },
                        icon: const Icon(Icons.qr_code_scanner_rounded),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  readOnly: loading,
                  controller: _itemName,
                  keyType: kKeyTextType,
                  title: 'Item Name',
                  validator: (name) =>
                      name!.length < 3 ? 'Please enter a valid name' : null,
                  onErase: () => _itemName.clear(),
                ),
                CustomTextField(
                  readOnly: loading,
                  controller: _description,
                  title: 'Description',
                  keyType: kKeyTextType,
                  placeholder: 'Enter item description',
                  validator: (name) => name!.length < 3
                      ? 'Please enter a valid description'
                      : null,
                  onErase: () => _description.clear(),
                ),
                CustomTextField(
                  readOnly: loading,
                  controller: _price,
                  keyType: kKeyNumberType,
                  placeholder: '0.00',
                  title: 'Price',
                  validator: (price) =>
                      price!.isEmpty ? 'Please enter price' : null,
                  onErase: () => _price.clear(),
                ),
                CustomTextField(
                  readOnly: loading,
                  controller: _quantity,
                  keyType: kKeyNumberType,
                  // initialValue: '1',
                  placeholder: '1',
                  title: 'Quantity',
                  validator: (quantity) =>
                      quantity!.isEmpty ? 'Please enter quantity' : null,
                  onErase: () => _quantity.clear(),
                ),
                CustomTextField(
                  readOnly: loading,
                  controller: _stock,
                  keyType: kKeyNumberType,
                  placeholder: '0',
                  title: 'Stock',
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter stock' : null,
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
                CustomTextField(
                  readOnly: loading,
                  controller: _tax,
                  keyType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  placeholder: '0%',
                  title: 'Tax %',
                  validator: (tax) => tax!.isEmpty ? 'Please enter tax' : null,
                  onErase: () => _tax.clear(),
                ),
                Center(
                  child: CustomTextButton(
                    onPressed: () async {
                      // check if the input is valid before submitting it
                      bool? valid = _formKey.currentState?.validate();
                      if (valid == true) {
                        Item newItem = generateNewItem();
                        try {
                          updateLoadingStata(true);

                          if (mode == ScreenMode.navigate) {
                            context
                                .read<ItemBloc>()
                                .add(AddItemEvent(item: newItem));
                            displaySnackBar('Item created successfully');
                            clearUserInput();
                          } else if (mode == ScreenMode.update) {
                            try {
                              context.read<ItemBloc>().add(UpdateItemEvent(
                                    item: newItem,
                                    id: _id!,
                                  ));
                              displaySnackBar('Item updated successfully');
                            } catch (e) {
                              displayErrorDialog(e);
                            }
                          }
                          updateLoadingStata(false);
                        } catch (e) {
                          updateLoadingStata(false);
                          displayErrorDialog(e);
                        }
                      }
                    },
                    label: loading
                        ? const CustomCircularProgress()
                        : Text(
                            mode == ScreenMode.navigate
                                ? 'Save Item'
                                : 'Update Item',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                    w: 180,
                    h: 56,
                    bg: theme.primaryColor,
                    fg: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String result = await scanner.scan(context);
          setState(() {
            barCode = result;
          });
        },
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.barcode_reader),
        label: const Text('Scan'),
      ),
    );
  }
}
