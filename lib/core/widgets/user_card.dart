import 'package:flutter/material.dart';

import 'client_Image.dart';

class UserCard extends StatelessWidget {
  final VoidCallback onPressed;

  final double? w;
  final double? elevation;
  final String title;
  final String subTitle;

  const UserCard({
    super.key,
    required this.onPressed,
    this.w,
    this.elevation,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: w ?? double.infinity,
        constraints: const BoxConstraints(minHeight: 80),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isDark ? Colors.white10 : const Color.fromRGBO(0, 0, 0, 0.05),
            width: 1,
          ),
          boxShadow: [
            if (!isDark)
              const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
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
            Icon(
              Icons.chevron_right_rounded,
              color: isDark
                  ? Colors.white38
                  : Color.fromRGBO(theme.primaryColor.red,
                      theme.primaryColor.green, theme.primaryColor.blue, 0.4),
            ),
          ],
        ),
      ),
    );
  }
}
