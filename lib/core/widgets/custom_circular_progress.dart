import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  final double? h;
  final double? w;
  final Color? color;
  final double? strokeWidth;

  const CustomCircularProgress(
      {super.key, this.h, this.w = 20, this.color, this.strokeWidth = 4});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: w! + 10,
      child: Center(
        child: SizedBox(
          height: h ?? 20,
          width: w ?? 20,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth ?? 4,
            valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.red),
          ),
        ),
      ),
    );
  }
}
