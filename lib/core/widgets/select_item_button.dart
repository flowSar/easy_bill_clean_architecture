import 'package:flutter/material.dart';

import '../constance/colors.dart';



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
    return RawMaterialButton(
      elevation: elevation ?? 6,
      onPressed: onPressed,
      padding: EdgeInsets.all(15),
      fillColor: greyLight,
      constraints:
          BoxConstraints(maxWidth: w ?? MediaQuery.of(context).size.width),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1, color: Colors.black38)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.ltr,
        spacing: 16,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Icon(Icons.add),
        ],
      ),
    );
  }
}
