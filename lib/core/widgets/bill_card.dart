import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



final kBillCardText = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
  color: Colors.blue,
);

class BillCard extends StatefulWidget {
  final String client;
  final String date;
  final String billNumber;
  final String total;

  const BillCard({
    super.key,
    required this.client,
    required this.date,
    required this.billNumber,
    required this.total,
  });

  @override
  State<BillCard> createState() => _BillCardState();
}

class _BillCardState extends State<BillCard> {
  bool isDarkMode = false;

  @override
  void initState() {
    // isDarkMode = context.read<SettingsProvider>().isDarMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currency = 'dh';
    // String currency = context.read<SettingsProvider>().currency;
    // SettingsProvider language = context.read<SettingsProvider>();
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            spacing: 6,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.client,
                    style: kBillCardText,
                  ),
                  Text(
                    'B.N: ${widget.billNumber}',
                    style: kBillCardText,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ctd Date',
                    style: kBillCardText.copyWith(
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  Text(
                    widget.date,
                    style: kBillCardText,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: kBillCardText.copyWith(
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  Text(
                    '${widget.total} $currency',
                    style: kBillCardText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
