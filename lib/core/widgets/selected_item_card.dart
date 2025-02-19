import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../constance/colors.dart';
import 'custom_popup_menu_button.dart';

class SelectedItemCard extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdite;
  final String name;
  final String barCode;
  final double tax;
  final double quantity;
  final double price;
  final Color? bg;

  const SelectedItemCard({
    super.key,
    required this.name,
    required this.barCode,
    required this.quantity,
    required this.price,
    required this.tax,
    required this.onEdite,
    required this.onDelete,
    this.bg,
  });

  @override
  Widget build(BuildContext context) {
    // String currency = context.read<SettingsProvider>().currency;
    final double dTax = tax;
    final subTotal = price * quantity;
    final double total = subTotal + (subTotal * dTax) / 100;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      height: 76,
      decoration: BoxDecoration(
          color: bg ?? kCustomCardBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: kBorderColor,
          )),
      child: Padding(
        padding: EdgeInsets.only(top: 6, bottom: 8, left: 10, right: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        maxLines: 1,
                      ),
                      Text(
                        '$quantity X $price',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        maxLines: 1,
                      ),
                      Text(
                        '$tax %',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        barCode,
                        style: TextStyle(fontSize: 12),
                      ),
                      BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                          late String currency = 'dh';
                          currency = state.currency!;
                          return Text(
                            '$total $currency',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child:
                  CustomPopupMenuButton(onDelete: onDelete, onEdite: onEdite),
            )
          ],
        ),
      ),
    );
  }
}
