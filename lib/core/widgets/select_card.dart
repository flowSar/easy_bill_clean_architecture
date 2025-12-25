import 'package:easy_bill_clean_architecture/core/widgets/text_card.dart';
import 'package:flutter/material.dart';

class SelectCard extends StatelessWidget {
  final VoidCallback onTap;
  final Color? bg;
  final IconData leftIcon;
  final Widget rightIcon;
  final String middleText;
  final double? p;

  const SelectCard({
    super.key,
    required this.onTap,
    this.bg,
    required this.leftIcon,
    required this.middleText,
    required this.rightIcon,
    this.p,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: TextCard(
          bg: bg,
          p: p ?? 16,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color.fromRGBO(255, 255, 255, 0.05)
                      : Color.fromRGBO(
                          theme.primaryColor.red,
                          theme.primaryColor.green,
                          theme.primaryColor.blue,
                          0.1,
                        ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  leftIcon,
                  size: 22,
                  color: isDark ? Colors.white : theme.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  middleText,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              rightIcon,
            ],
          ),
        ),
      ),
    );
  }
}
