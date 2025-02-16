import 'package:flutter/material.dart';

class ClientImage extends StatelessWidget {
  final String cName;
  final Color? bg;
  final Color? fg;
  final double? w;
  final double? h;
  final double? m;

  const ClientImage({
    super.key,
    required this.cName,
    this.bg,
    this.fg,
    this.w = 70,
    this.h = 70,
    this.m = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(m ?? 0),
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: bg ?? Colors.blueGrey,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          cName[0].toUpperCase(),
          style: TextStyle(
            color: fg ?? Colors.white,
            fontSize: (w! / 2.5),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
