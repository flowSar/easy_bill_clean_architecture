import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final double dTax = tax;
    final subTotal = price * quantity;
    final double total = subTotal + (subTotal * dTax) / 100;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: bg ?? theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? Colors.white10 : const Color.fromRGBO(0, 0, 0, 0.05),
        ),
        boxShadow: [
          if (!isDark)
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.03),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${quantity.toStringAsFixed(0)} x ${price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: theme.textTheme.bodySmall?.color != null
                              ? Color.fromRGBO(
                                  theme.textTheme.bodySmall!.color!.red,
                                  theme.textTheme.bodySmall!.color!.green,
                                  theme.textTheme.bodySmall!.color!.blue,
                                  0.6)
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax: $tax%',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.textTheme.bodySmall?.color != null
                              ? Color.fromRGBO(
                                  theme.textTheme.bodySmall!.color!.red,
                                  theme.textTheme.bodySmall!.color!.green,
                                  theme.textTheme.bodySmall!.color!.blue,
                                  0.5)
                              : Colors.grey,
                        ),
                      ),
                      BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                          String currency = state.currency ?? '\$';
                          return Text(
                            '${total.toStringAsFixed(2)} $currency',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: theme.primaryColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    barCode,
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.textTheme.bodySmall?.color != null
                          ? Color.fromRGBO(
                              theme.textTheme.bodySmall!.color!.red,
                              theme.textTheme.bodySmall!.color!.green,
                              theme.textTheme.bodySmall!.color!.blue,
                              0.4)
                          : Colors.grey,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            CustomPopupMenuButton(onDelete: onDelete, onEdite: onEdite),
          ],
        ),
      ),
    );
  }
}
