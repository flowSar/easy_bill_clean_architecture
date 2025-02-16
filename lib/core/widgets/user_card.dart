
import 'package:flutter/material.dart';

import '../constance/colors.dart';
import 'client_Image.dart';



class UserCard extends StatelessWidget {
  final VoidCallback onPressed;

  final double? w;
  final double? elevation;
  final String title;
  final String subTitle;

  const UserCard({
    super.key,
    required this.onPressed,
    this.w,
    this.elevation,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: elevation ?? 6,
      onPressed: onPressed,
      padding: EdgeInsets.all(6),
      fillColor: greyLight,
      constraints: BoxConstraints(
        maxWidth: w ?? MediaQuery.of(context).size.width,
        minHeight: 70,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1, color: Colors.black38)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 10,
        children: [
          ClientImage(
            cName: title,
            w: 48,
            h: 48,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text('Name: $title'),
              Text('Email: $subTitle'),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
