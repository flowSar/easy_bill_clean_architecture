import 'dart:io';

import 'package:flutter/material.dart';
import 'package:async_preferences/async_preferences.dart';

import '../../../../core/widgets/custom_text_field.dart';

final preferences = AsyncPreferences();

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

List<String> options = ['option 1', 'option 2'];

class _AboutScreenState extends State<AboutScreen> {
  late File? imageFile = null;
  final bool notEmpty = false;
  late String unit = 'Unit';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(padding: EdgeInsets.all(10), child: About()
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     SizedBox(
          //       width: double.infinity,
          //       child: TextButton(
          //         onPressed: () {
          //           print('Hello wolrd');
          //         },
          //         child: Text('load'),
          //       ),
          //     ),
          //     CustomTextButton(
          //       onPressed: () async {
          //         print('hello');
          //         try {
          //           int result =
          //               await DatabaseHelper.instance.insertSignaturePath('test');
          //           print('result: $result');
          //           List<Signature> items =
          //               await DatabaseHelper.instance.getSignaturePath();
          //           print('length: ${items.length}');
          //         } catch (e) {
          //           print('error: $e');
          //         }
          //       },
          //       label: Text('load'),
          //       bg: Colors.green,
          //       fg: Colors.white,
          //     ),
          //     Column(
          //       mainAxisSize: MainAxisSize.min,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.symmetric(
          //             horizontal: 14,
          //             vertical: 1,
          //           ),
          //           child: Text(
          //             'Unit:',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w600,
          //               fontSize: 14,
          //             ),
          //           ),
          //         ),
          //         UnitWidget(
          //           unit: unit,
          //           onChange: (String selectedUnit) {
          //             setState(() {
          //               unit = selectedUnit;
          //             });
          //           },
          //         ),
          //       ],
          //     ),
          //     TextButton(
          //         onPressed: () async {
          //           displaySaveInvoiceOption(context, (answer) {
          //             print('answer : $answer');
          //           });
          //         },
          //         child: Text('Open ')),
          //   ],
          // ),
          ),
    ));
  }
}

class CustomModal extends StatelessWidget {
  const CustomModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Hello world'),
          CustomTextField(
            title: 'Email',
            placeholder: 'Email',
            bg: Colors.green,
          ),
          CustomTextField(
            title: 'Email',
            placeholder: 'Email',
            bg: Colors.green,
          ),
        ],
      ),
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          Image.asset(
            'images/EasyBill.png',
            width: 200,
          ),
          Text('version 1.0.0'),
          Text(
            'EasyInvoice is a powerful app designed to streamline the billing and invoicing process',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17,
                color: Colors.blue[900],
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
