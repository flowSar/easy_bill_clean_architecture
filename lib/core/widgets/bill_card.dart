import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    // isDarkMode = context.read<SettingsBloc>().state.isDarkMode!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String currency = context.read<SettingsProvider>().currency;
    // SettingsProvider language = context.read<SettingsProvider>();
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                bool isDarkMode = false;
                isDarkMode = state.isDarkMode!;
                return Column(
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
                        BlocBuilder<SettingsBloc, SettingsState>(
                          builder: (context, state) {
                            late String currency = 'dh';
                            currency = state.currency!;
                            return Text(
                              '${widget.total} $currency',
                              style: kBillCardText,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
