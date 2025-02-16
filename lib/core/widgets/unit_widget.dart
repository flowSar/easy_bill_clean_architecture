
import 'package:easy_bill_clean_architecture/core/widgets/unit_dialog.dart';
import 'package:flutter/material.dart';

import '../constance/colors.dart';



class UnitWidget extends StatefulWidget {
  final Function(String unit) onChange;
  final String unit;

  const UnitWidget({
    super.key,
    required this.unit,
    required this.onChange,
  });

  @override
  State<UnitWidget> createState() => _UnitWidgetState();
}

class _UnitWidgetState extends State<UnitWidget> {
  late String unit = widget.unit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return UnitDialog(
                unit: unit,
              );
            }).then((selectedUnit) {
          setState(() {
            unit = selectedUnit;
            widget.onChange(unit);
          });
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: kTextInputBg1,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                unit,
              ),
              Icon(
                Icons.keyboard_arrow_down_sharp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
