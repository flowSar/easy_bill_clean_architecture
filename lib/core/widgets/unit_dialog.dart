import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnitDialog extends StatefulWidget {
  final String unit;

  const UnitDialog({super.key, required this.unit});

  @override
  State<UnitDialog> createState() => _UnitDialogState();
}

class _UnitDialogState extends State<UnitDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 70),
      titlePadding: EdgeInsets.only(
        top: 14,
        left: 14,
        right: 14,
      ),
      contentPadding: EdgeInsets.only(top: 6, bottom: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Units',
            style: TextStyle(fontSize: 20),
          ),
          InkWell(
              onTap: () {
                context.pop(widget.unit);
              },
              child: Icon(Icons.close)),
        ],
      ),
      content: SizedBox(
        height: 180,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            InkWell(
              onTap: () {
                context.pop('unit');
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Text('No Unit')),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                context.pop('hrs');
              },
              child: UnitItem(
                unit: 'hrs',
              ),
            ),
            InkWell(
              onTap: () {
                context.pop('kgs');
              },
              child: UnitItem(
                unit: 'kgs',
              ),
            ),
            InkWell(
              onTap: () {
                context.pop('pcs');
              },
              child: UnitItem(
                unit: 'pcs',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnitItem extends StatelessWidget {
  final String unit;

  const UnitItem({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(unit)),
      ),
    );
  }
}
