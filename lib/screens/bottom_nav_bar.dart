import 'package:easy_bill_clean_architecture/features/presentation/clients/screens/clients_screen.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/screens/invoice_screen.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import '../core/constance/g_constants.dart';
import '../features/presentation/invoices/screens/new_invoice_screen.dart';
import '../features/presentation/items/screens/items_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _screenIndex = 0;
  final List<Widget> screens = [
    NewInvoiceScreen(),
    InvoiceScreen(),
    ClientsScreen(
      mode: ScreenMode.navigate,
    ),
    ItemsScreen(
      mode: ScreenMode.navigate,
    ),
    SettingsScreen(),
  ];

  void _handleItemTaped(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // load language dictionary
    // SettingsProvider language = context.watch<SettingsProvider>();
    return Scaffold(
      body: screens[_screenIndex],
      // this will prevent the keyBoard from pushing the widget upward in the main bottomnavigationBar screens
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _screenIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey.shade500,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
        onTap: _handleItemTaped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add_rounded, size: 26),
            activeIcon: Icon(Icons.note_add_rounded, size: 28),
            label: 'Invoice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded, size: 26),
            activeIcon: Icon(Icons.receipt_long_rounded, size: 28),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_rounded, size: 26),
            activeIcon: Icon(Icons.group_rounded, size: 28),
            label: 'Clients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded, size: 26),
            activeIcon: Icon(Icons.category_rounded, size: 28),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_suggest_rounded, size: 26),
            activeIcon: Icon(Icons.settings_suggest_rounded, size: 28),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
