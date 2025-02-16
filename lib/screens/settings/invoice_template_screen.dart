import 'package:flutter/material.dart';

class InvoiceTemplateScreen extends StatefulWidget {
  const InvoiceTemplateScreen({super.key});

  @override
  State<InvoiceTemplateScreen> createState() => _InvoiceTemplateScreenState();
}

class _InvoiceTemplateScreenState extends State<InvoiceTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Inoice tamplates',
        ),
      ),
      body: Center(
        child: Text(
          'this future is not available coming soon',
        ),
      ),
    ));
  }
}
