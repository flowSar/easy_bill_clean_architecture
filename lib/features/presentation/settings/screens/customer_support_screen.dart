import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constance/g_constants.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';

final _formKey = GlobalKey<FormState>();

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  late TextEditingController _msgText;
  late TextEditingController _subject;
  late int msgLength = 0;

  @override
  void initState() {
    super.initState();

    _msgText = TextEditingController();
    _subject = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _msgText.dispose();
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void> _launchEmail(String subject, String msg) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'sar@example.com',
      query: encodeQueryParameters(
        <String, String>{
          'subject': subject,
          'body': msg,
        },
      ),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Customer support'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 80, left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    title: 'Subject',
                    bg: Colors.grey[300],
                    controller: _subject,
                    placeholder: 'subject',
                    onErase: () {
                      _subject.clear();
                    },
                    validator: (subject) =>
                        subject!.length < 4 ? 'message subject missing' : null,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: TextFormField(
                          controller: _msgText,
                          validator: (msg) =>
                              msg!.length < 10 ? 'message is to short' : null,
                          maxLength: 150,
                          minLines: 8,
                          keyboardType: kKeyTextType,
                          onChanged: (msg) {
                            setState(() {
                              msgLength = msg.length;
                            });
                          },
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.grey[300],
                            focusColor: Colors.redAccent,
                            hintText:
                                'Describe your issue in less than 150 character',
                          ),
                        ),
                      ),
                    ),
                  ),
                  CustomTextButton(
                      onPressed: () {
                        bool? result = _formKey.currentState?.validate();
                        if (result == true) {
                          _launchEmail(_subject.text, _msgText.text);
                        } else {
                          showErrorDialog(context, 'Error',
                              'please insert valid input Subject+message');
                        }
                      },
                      label: Text('Send'),
                      bg: Colors.green,
                      fg: Colors.white)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
