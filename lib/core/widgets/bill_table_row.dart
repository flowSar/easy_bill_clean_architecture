import 'package:flutter/material.dart';

import '../constance/colors.dart';



class BillTableRow extends StatelessWidget {
  final String product;
  final String quantity;
  final String price;
  final String total;
  final String tax;

  const BillTableRow({
    super.key,
    required this.product,
    required this.quantity,
    required this.price,
    required this.total,
    required this.tax,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(color: greyLight),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 2,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  product,
                  maxLines: 1,
                )),
            Expanded(
                flex: 1,
                child: Text(
                  quantity,
                  maxLines: 1,
                )),
            Expanded(
                flex: 1,
                child: Text(
                  price,
                  maxLines: 1,
                )),
            Expanded(
                flex: 1,
                child: Text(
                  '$tax%',
                  maxLines: 1,
                )),
            Expanded(
                flex: 1,
                child: Text(
                  total,
                  maxLines: 1,
                )),
          ],
        ),
      ),
    );
  }
}
