import 'package:flutter/material.dart';

import '../constance/g_constants.dart';



class TextCard extends StatelessWidget {
  final Widget child;
  final Color? bg;
  final double? w;
  final double? elevation;
  final double? p;

  const TextCard({
    super.key,
    required this.child,
    this.bg,
    this.w,
    this.elevation,
    this.p,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Material(
        elevation: elevation ?? 1,
        child: Container(
          width: w ?? maxW,
          decoration: BoxDecoration(
            color: bg ?? Colors.white30,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: p ?? 15, vertical: p ?? 20),
            child: child,
          ),
        ),
      ),
    );
  }
}
