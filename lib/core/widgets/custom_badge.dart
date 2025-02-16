import 'package:flutter/material.dart';

import '../constance/colors.dart';



class Custombadge extends StatelessWidget {
  final IconData icon;
  final IconData labelIcon;
  final Color? labelBg;

  const Custombadge(
      {super.key, required this.icon, required this.labelIcon, this.labelBg});

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 3),
        child: Icon(
          labelIcon,
          color: Colors.black38,
          size: 20,
        ),
      ),
      backgroundColor: Colors.green[300],
      offset: Offset(-20, 60),
      child: CircleAvatar(
        backgroundColor: kAvatarBg,
        radius: 45,
        child: Icon(
          icon,
          color: labelBg ?? Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
