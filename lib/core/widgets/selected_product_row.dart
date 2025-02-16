import 'package:flutter/material.dart';

class SelectedProductRow extends StatelessWidget {
  const SelectedProductRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text('quantity'),
          ),
          Expanded(
            flex: 2,
            child: Text('product'),
          ),
          Expanded(
            flex: 1,
            child: Text('price'),
          ),
          Expanded(
            flex: 1,
            child: Text('total'),
          ),
        ],
      ),
    );
  }
}
