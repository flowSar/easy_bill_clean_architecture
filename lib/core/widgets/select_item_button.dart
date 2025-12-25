import 'package:flutter/material.dart';

class SelectItemButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double? w;
  final double? elevation;

  const SelectItemButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.w,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: w ?? double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: isDark
              ? const Color.fromRGBO(255, 255, 255, 0.05)
              : const Color.fromRGBO(158, 158, 158, 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isDark ? Colors.white10 : const Color.fromRGBO(0, 0, 0, 0.08),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.add_circle_outline_rounded,
              color: theme.primaryColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
