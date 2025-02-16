import 'package:easy_bill_clean_architecture/features/presentation/clients/screens/clients_screen.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/screens/invoice_screen.dart';
import 'package:easy_bill_clean_architecture/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: _handleItemTaped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.create,
            ),
            label: 'Invoice',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.fileInvoice,
              ),
              label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.users,
              ),
              label: 'Clients'),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.list,
              ),
              label: 'Items'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: 'Settings'),
        ],
      ),
    );
  }
}
