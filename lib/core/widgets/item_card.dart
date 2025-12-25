import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'custom_popup_menu_button.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? tailing;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdite;

  const ItemCard({
    super.key,
    required this.title,
    this.subTitle = '',
    this.tailing = '',
    required this.onTap,
    required this.onDelete,
    required this.onEdite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? const Color.fromRGBO(255, 255, 255, 0.1)
                : const Color.fromRGBO(0, 0, 0, 0.05),
            width: 1,
          ),
          boxShadow: [
            if (!isDark)
              const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.03),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subTitle != null && subTitle!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subTitle!,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.textTheme.bodySmall?.color != null
                            ? Color.fromRGBO(
                                theme.textTheme.bodySmall!.color!.red,
                                theme.textTheme.bodySmall!.color!.green,
                                theme.textTheme.bodySmall!.color!.blue,
                                0.6)
                            : Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                final String currency = state.currency ?? '\$';
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(
                      theme.primaryColor.red,
                      theme.primaryColor.green,
                      theme.primaryColor.blue,
                      0.1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${tailing ?? '0.00'} $currency',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            CustomPopupMenuButton(onDelete: onDelete, onEdite: onEdite),
          ],
        ),
      ),
    );
  }
}
