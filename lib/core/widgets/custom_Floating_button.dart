import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double? w;
  final double? h;

  const CustomFloatingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.w,
    this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: RawMaterialButton(
        elevation: 6,
        fillColor: Colors.purple[700],
        // fillColor: Color(0xff4CAF50),
        constraints: BoxConstraints.tightFor(
          width: w ?? 60,
          height: h ?? 50,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
