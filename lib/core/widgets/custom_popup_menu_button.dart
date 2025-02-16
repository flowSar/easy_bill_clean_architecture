import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdite;

  const CustomPopupMenuButton(
      {super.key, required this.onDelete, required this.onEdite});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'delete') {
          onDelete();
        } else if (value == 'edite') {
          onEdite();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'delete',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 10,
            children: [
              Text(
                'Delete',
                style: TextStyle(color: Colors.black38, fontSize: 18),
              ),
              Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'edite',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edite',
                style: TextStyle(color: Colors.black38, fontSize: 18),
              ),
              Icon(
                Icons.edit,
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ],
      child: Padding(padding: EdgeInsets.all(4), child: Icon(Icons.more_vert)),
    );
  }
}
