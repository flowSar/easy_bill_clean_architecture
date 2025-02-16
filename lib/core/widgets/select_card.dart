
import 'package:easy_bill_clean_architecture/core/widgets/text_card.dart';
import 'package:flutter/material.dart';

import '../constance/colors.dart';


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
    return InkWell(
      onTap: onTap,
      child: TextCard(
        bg: bg ?? greyLight,
        p: p,
        child: Row(
          spacing: 30,
          children: [
            Icon(leftIcon),
            Expanded(
              child: Text(
                middleText,
                style: TextStyle(fontSize: 16),
              ),
            ),
            rightIcon,
          ],
        ),
      ),
    );
  }
}
