import 'package:flutter/material.dart';
import '../constance/colors.dart';
import 'client_Image.dart';
import 'custom_popup_menu_button.dart';

class ClientCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Icon? icon;
  final VoidCallback onDelete;
  final VoidCallback onEdite;
  final VoidCallback onTap;
  final double? m;
  final Color? bg;

  const ClientCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon,
    required this.onEdite,
    required this.onDelete,
    required this.onTap,
    this.m,
    this.bg,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: m ?? 10, vertical: 5),
        decoration: BoxDecoration(
            color: bg ?? greyLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black38,
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ClientImage(
                  cName: title,
                  w: 55,
                  h: 55,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text('Name: $title'),
                    Text('Email: $subTitle'),
                  ],
                ),
              ),
              CustomPopupMenuButton(
                onDelete: onDelete,
                onEdite: onEdite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
