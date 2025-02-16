import 'package:flutter/material.dart';

import '../widgets/dialog_option.dart';

bool isValidNumber(String str) {
  int? number = int.tryParse(str);
  if (number != null) {
    return true;
  }
  return false;
}

// function for validating the Email
bool isEmailValid(String email) {
  // Regular expression to validate email addresses
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}

// snack bar widget
snackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: 1000),
    ),
  );
}

void displaySaveInvoiceOption(
    BuildContext context, void Function(bool answer) fn) {
  showDialog(
    context: context,
    builder: (context) => DialogOption(
      title: Text('Save invoice'),
      content: Text('Are you sure you wanna save this invoice'),
      yesFunction: () {
        fn(true);
        Navigator.pop(context);
      },
      noFunction: () {
        fn(false);
        Navigator.pop(context);
      },
    ),
  );
}

String formatNumber(int num) {
  if (num < 10) {
    return '00$num';
  } else if (num < 100) {
    return '0$num';
  } else {
    return '$num';
  }
}
