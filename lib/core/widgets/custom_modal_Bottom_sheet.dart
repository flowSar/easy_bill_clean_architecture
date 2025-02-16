import 'package:easy_bill_clean_architecture/core/widgets/text_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../constance/colors.dart';
import '../constance/g_constants.dart';
import '../constance/styles.dart';
import '../models/item.dart';
import 'custom_text_button.dart';
import 'custom_text_field.dart';

final _formKey = GlobalKey<FormState>();

class CustomModalBottomSheet extends StatefulWidget {
  final String? barCode;
  final Item? item;

  const CustomModalBottomSheet({super.key, this.barCode, this.item});

  @override
  State<CustomModalBottomSheet> createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  late final TextEditingController _itemName;
  late final TextEditingController _price;
  late final TextEditingController _quantity;
  late final TextEditingController _tax;
  bool isDarkMode = false;

  // late Item? foundItem;

  @override
  void initState() {
    _itemName = TextEditingController();
    _price = TextEditingController();
    _quantity = TextEditingController();
    _tax = TextEditingController();

    if (widget.item != null) {
      _itemName.text = widget.item!.name;
      _price.text = widget.item!.price.toString();
      _quantity.text = widget.item!.quantity.toString();
      _tax.text = widget.item!.tax.toString();
    }
    // isDarkMode = context.read<SettingsProvider>().isDarMode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late String? barCode = widget.barCode;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextCard(
                  bg: isDarkMode ? Colors.white : kTextInputBg1,
                  w: 340,
                  p: 18,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'barCode: $barCode',
                        style: kTextStyle2,
                      ),
                    ],
                  )),
              CustomTextField(
                title: 'Full name',
                readOnly: true,
                controller: _itemName,
                keyType: kKeyTextType,
                placeholder: 'Item name',
                bg: kTextInputBg1,
              ),
              CustomTextField(
                title: 'Price',
                readOnly: true,
                controller: _price,
                keyType: kKeyNumberType,
                placeholder: 'Price',
                bg: kTextInputBg1,
              ),
              CustomTextField(
                title: 'Quantity',
                controller: _quantity,
                keyType: kKeyNumberType,
                placeholder: 'Item quantity',
                bg: kTextInputBg1,
                validator: (quantity) => quantity!.isEmpty || quantity == '0'
                    ? 'please Insert valid input'
                    : null,
              ),
              // CustomTextField(
              //   title: 'Tax',
              //   readOnly: true,
              //   controller: _tax,
              //   keyType: kKeyNumberType,
              //   placeholder: 'Tax Percentage',
              //   bg: kTextInputBg1,
              //   validator: (quantity) =>
              //       quantity!.isEmpty ? 'please Insert valid input' : null,
              // ),
              CustomTextButton(
                onPressed: () {
                  bool? isInputValid = _formKey.currentState!.validate();
                  if (isInputValid) {
                    Item newItem = Item(
                      barCode: widget.barCode!,
                      name: _itemName.text,
                      price: double.parse(_price.text),
                      quantity: double.parse(_quantity.text),
                      tax: widget.item!.tax,
                      description: widget.item!.description,
                      unit: widget.item!.unit,
                      stock: widget.item!.stock,
                    );
                    context.pop(newItem);
                  }
                },
                label: Text(
                  'add',
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
    );
  }
}
