import 'package:flutter/material.dart';

import '../constance/g_constants.dart';

class TextCard extends StatelessWidget {
  final Widget child;
  final Color? bg;
  final double? w;
  final double? p;

  const TextCard({
    super.key,
    required this.child,
    this.bg,
    this.w,
    this.p,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: bg ??
            (isDark
                ? const Color.fromRGBO(255, 255, 255, 0.05)
                : const Color.fromRGBO(0, 0, 0, 0.02)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? const Color.fromRGBO(255, 255, 255, 0.08)
              : const Color.fromRGBO(0, 0, 0, 0.05),
          width: 1,
        ),
      ),
      child: Container(
        width: w ?? maxW,
        padding: EdgeInsets.symmetric(
          horizontal: p ?? 16,
          vertical: p ?? 16,
        ),
        child: child,
      ),
    );
  }
}
