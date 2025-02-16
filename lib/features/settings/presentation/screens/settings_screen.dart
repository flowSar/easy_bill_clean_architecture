
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/currency_dialog.dart';
import '../../../../core/widgets/language_dialog.dart';
import '../../../../core/widgets/select_card.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = true;
  late String selectedCurrency = '\$';
  late bool _isSwitched;

  @override
  void initState() {
    // _isSwitched = context.read<SettingsProvider>().isDarMode;
    // load currency / or selected currency
    // context.read<SettingsProvider>().loadCurrency();
    // assign loaded currency to selectedCurrency
    // selectedCurrency = context.read<SettingsProvider>().currency;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // load language dictionary
    // SettingsProvider language = context.watch<SettingsProvider>();
    void replaceCurrentScreen() {
      context.replace('/signIn');
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Settings')),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Account & business',
                  style:
                      TextStyle(color: Colors.greenAccent[700], fontSize: 20),
                ),
              ),
              SelectCard(
                p: 14,
                onTap: () async {
                  context.push('/businessScreen');
                },
                leftIcon: Icons.add,
                middleText: 'Your Business',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
              SelectCard(
                p: 14,
                onTap: () async {
                  context.push('/aboutScreen');
                },
                leftIcon: Icons.info_outline,
                middleText: 'About',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'general',
                  style:
                      TextStyle(color: Colors.greenAccent[700], fontSize: 20),
                ),
              ),
              SelectCard(
                onTap: () {},
                leftIcon: Icons.nightlight,
                middleText: 'Night Mode',
                p: 9,
                rightIcon: Switch(
                  value: _isSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isSwitched = value;
                      // context.read<SettingsProvider>().setDarkMode(value);
                    });
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
              SelectCard(
                p: 14,
                onTap: () {
                  showDialog(
                          context: context,
                          builder: (BuildContext context) => CurrencyDialog())
                      .then((currency) {
                    if (currency != null) {
                      setState(() {
                        selectedCurrency = currency.toString();
                      });
                    }
                  });
                },
                leftIcon: Icons.currency_exchange,
                middleText:
                    '${'Currency'} ($selectedCurrency)',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
              SelectCard(
                p: 14,
                onTap: () {
                  context.push('/signatureScreen');
                },
                leftIcon: FontAwesomeIcons.fileSignature,
                middleText: 'Signature',
                rightIcon: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
              SelectCard(
                p: 14,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => LanguageDialog(),
                  );
                },
                leftIcon: FontAwesomeIcons.language,
                middleText: 'Language',
                rightIcon: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
              SelectCard(
                p: 14,
                onTap: () {
                  context.push(
                    '/invoiceTemplateScreen',
                  );
                },
                leftIcon: Icons.picture_as_pdf,
                middleText: 'Invoice templates',
                rightIcon: Icon(
                  Icons.keyboard_arrow_right,
                ),
              ),
              SelectCard(
                p: 14,
                onTap: () {
                  context.push('/customerSupportScreen');
                },
                leftIcon: Icons.contact_support_outlined,
                middleText: 'Customer support',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
              SelectCard(
                p: 14,
                onTap: () {},
                leftIcon: Icons.code,
                middleText: 'Version 1.0.0',
                rightIcon: Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
