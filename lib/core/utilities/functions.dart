import 'package:easy_bill_clean_architecture/core/models/invoice.dart';
import 'package:easy_bill_clean_architecture/features/domain/clients/model/client.dart';
import 'package:easy_bill_clean_architecture/features/domain/invoices/entities/invoice.dart';
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

Client getClientById(List<Client> clients, int id) {
  final foundClient = clients.where((client) => client.id == id).toList();
  return foundClient[0];
}

List<int?> getClientsId(List<Client> clients, String keyWord) {
  return clients.map((client) {
    if (client.fullName.contains(keyWord)) {
      return client.id;
    }
    return 0;
  }).toList();
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

GeneralInvoice generateGeneralInvoice(Invoice invoice, Client client) {
  return GeneralInvoice(
    id: invoice.id,
    clientId: client.id,
    date: invoice.date,
    total: invoice.total,
    clientName: client.fullName,
    clientAddress: client.address,
    clientEmail: client.email,
    clientPhoneNumber: client.phoneNumber,
    invoiceNumber: invoice.invoiceNumber,
    rest: invoice.rest,
    pay: invoice.pay,
    items: invoice.items,
  );
}
