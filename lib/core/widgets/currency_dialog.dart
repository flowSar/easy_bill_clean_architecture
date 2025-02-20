import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../features/presentation/settings/bloc/settings_event.dart';
import '../models/currency.dart';

class CurrencyDialog extends StatefulWidget {
  const CurrencyDialog({super.key});

  @override
  State<CurrencyDialog> createState() => _CurrencyDialogState();
}

class _CurrencyDialogState extends State<CurrencyDialog> {
  late String selectedCurrency = 'dh';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(top: 10, left: 20),
      actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        'currencies',
        style: TextStyle(fontSize: 25, color: Colors.greenAccent[700]),
      ),
      content: SizedBox(
        height: 360,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Divider(),
            Expanded(
              child: ListView.builder(
                  itemCount: Currency.currencies.length,
                  itemBuilder: (context, index) {
                    return BlocBuilder<SettingsBloc, SettingsState>(
                      builder: (context, state) {
                        selectedCurrency = state.currency!;
                        return RadioMenuButton(
                          value: Currency.currencies[index].symbol,
                          groupValue: selectedCurrency,
                          onChanged: (value) {
                            setState(() {
                              selectedCurrency = value.toString();
                              context
                                  .read<SettingsBloc>()
                                  .add(SetCurrencyEvent(value.toString()));
                            });
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Currency.currencies[index].country),
                                Text(Currency.currencies[index].symbol)
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
            Divider(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(selectedCurrency); // Close the dialog
          },
          child: Text(
            'Save',
            style: TextStyle(fontSize: 16, color: Colors.greenAccent[700]),
          ),
        ),
      ],
    );
  }
}
