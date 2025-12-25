import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
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
  late bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context, 'Account & Business'),
              SelectCard(
                onTap: () => context.push('/businessScreen'),
                leftIcon: Icons.business_center_rounded,
                middleText: 'Your Business',
                rightIcon: const Icon(Icons.chevron_right_rounded, size: 20),
              ),
              SelectCard(
                onTap: () => context.push('/signatureScreen'),
                leftIcon: Icons.draw_rounded,
                middleText: 'Signature',
                rightIcon: const Icon(Icons.chevron_right_rounded, size: 20),
              ),
              SelectCard(
                onTap: () => context.push('/invoiceTemplateScreen'),
                leftIcon: Icons.description_rounded,
                middleText: 'Invoice Templates',
                rightIcon: const Icon(Icons.chevron_right_rounded, size: 20),
              ),
              const SizedBox(height: 12),
              _buildSectionHeader(context, 'Preferences'),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  _isSwitched = state.isDarkMode!;
                  return SelectCard(
                    onTap: () {},
                    leftIcon: Icons.dark_mode_rounded,
                    middleText: 'Dark Mode',
                    rightIcon: Switch(
                      value: _isSwitched,
                      activeColor: isDark ? Colors.white : theme.primaryColor,
                      onChanged: (value) {
                        setState(() {
                          _isSwitched = value;
                          context
                              .read<SettingsBloc>()
                              .add(SetThemeModeEvent(value));
                        });
                      },
                    ),
                  );
                },
              ),
              SelectCard(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const LanguageDialog(),
                  );
                },
                leftIcon: Icons.translate_rounded,
                middleText: 'Language',
                rightIcon: const Icon(Icons.chevron_right_rounded, size: 20),
              ),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  selectedCurrency = state.currency!;
                  return SelectCard(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CurrencyDialog(),
                      ).then((currency) {
                        if (currency != null) {
                          setState(() {
                            selectedCurrency = currency.toString();
                          });
                        }
                      });
                    },
                    leftIcon: Icons.payments_rounded,
                    middleText: 'Currency ($selectedCurrency)',
                    rightIcon:
                        const Icon(Icons.chevron_right_rounded, size: 20),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildSectionHeader(context, 'Support & Info'),
              SelectCard(
                onTap: () => context.push('/customerSupportScreen'),
                leftIcon: Icons.support_agent_rounded,
                middleText: 'Customer Support',
                rightIcon: const Icon(Icons.chevron_right_rounded, size: 20),
              ),
              SelectCard(
                onTap: () => context.push('/aboutScreen'),
                leftIcon: Icons.info_rounded,
                middleText: 'About',
                rightIcon: const Icon(Icons.chevron_right_rounded, size: 20),
              ),
              SelectCard(
                onTap: () {},
                leftIcon: Icons.terminal_rounded,
                middleText: 'Version',
                rightIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '1.0.0',
                    style: TextStyle(
                      color: isDark
                          ? const Color.fromRGBO(255, 255, 255, 0.4)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 4.0, top: 4.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: isDark
              ? const Color.fromRGBO(255, 255, 255, 0.5)
              : Color.fromRGBO(
                  theme.primaryColor.red,
                  theme.primaryColor.green,
                  theme.primaryColor.blue,
                  0.7,
                ),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
