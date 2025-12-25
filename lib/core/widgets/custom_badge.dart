import 'package:flutter/material.dart';

class Custombadge extends StatelessWidget {
  final IconData icon;
  final IconData labelIcon;
  final Color? labelBg;

  const Custombadge({
    super.key,
    required this.icon,
    required this.labelIcon,
    this.labelBg,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Badge(
      label: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          labelIcon,
          color: Colors.white,
          size: 16,
        ),
      ),
      backgroundColor: labelBg ?? theme.primaryColor,
      offset: const Offset(-8, 64),
      largeSize: 30,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark
              ? const Color.fromRGBO(255, 255, 255, 0.05)
              : const Color.fromRGBO(0, 0, 0, 0.05),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          child: Icon(
            icon,
            color: isDark
                ? const Color.fromRGBO(255, 255, 255, 0.7)
                : const Color.fromRGBO(0, 0, 0, 0.5),
            size: 48,
          ),
        ),
      ),
    );
  }
}
