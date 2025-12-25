import 'package:flutter/material.dart';

import 'client_Image.dart';
import 'custom_popup_menu_button.dart';

class ClientCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Icon? icon;
  final VoidCallback onDelete;
  final VoidCallback onEdite;
  final VoidCallback onTap;
  final double? m;
  final Color? bg;

  const ClientCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon,
    required this.onEdite,
    required this.onDelete,
    required this.onTap,
    this.m,
    this.bg,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: m ?? 12, vertical: 6),
        decoration: BoxDecoration(
          color: bg ?? theme.cardColor,
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
            ClientImage(
              cName: title,
              w: 52,
              h: 52,
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 4),
                  Text(
                    subTitle,
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
              ),
            ),
            CustomPopupMenuButton(
              onDelete: onDelete,
              onEdite: onEdite,
            ),
          ],
        ),
      ),
    );
  }
}
