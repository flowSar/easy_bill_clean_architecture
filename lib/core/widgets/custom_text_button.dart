import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget label;
  final Color bg;
  final Color fg;
  final double? w;
  final double? h;
  final double? bRadius;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.bg,
    required this.fg,
    this.w = 100,
    this.h = 30,
    this.bRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: 6,
          backgroundColor: bg,
          foregroundColor: fg,
          fixedSize: Size(w!, h!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(bRadius!),
          ),
        ),
        onPressed: onPressed,
        child: label,
      ),
    );
  }
}
