import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constance/g_constants.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  late TextEditingController _msgText;
  late TextEditingController _subject;
  late int msgLength = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _msgText = TextEditingController();
    _subject = TextEditingController();
  }

  @override
  void dispose() {
    _msgText.dispose();
    _subject.dispose();
    super.dispose();
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Support',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                CustomTextField(
                  title: 'Subject',
                  controller: _subject,
                  placeholder: 'What can we help you with?',
                  onErase: () => _subject.clear(),
                  validator: (subject) =>
                      subject!.length < 4 ? 'Message subject missing' : null,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color.fromRGBO(255, 255, 255, 0.05)
                          : const Color.fromRGBO(0, 0, 0, 0.03),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark
                            ? const Color.fromRGBO(255, 255, 255, 0.1)
                            : const Color.fromRGBO(0, 0, 0, 0.05),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: TextFormField(
                        controller: _msgText,
                        validator: (msg) =>
                            msg!.length < 10 ? 'Message is too short' : null,
                        maxLength: 150,
                        minLines: 6,
                        keyboardType: kKeyTextType,
                        onChanged: (msg) {
                          setState(() {
                            msgLength = msg.length;
                          });
                        },
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              'Describe your issue in less than 150 characters',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? const Color.fromRGBO(255, 255, 255, 0.3)
                                : const Color.fromRGBO(0, 0, 0, 0.3),
                          ),
                          counterText: "",
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      '$msgLength / 150',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? const Color.fromRGBO(255, 255, 255, 0.4)
                            : const Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: CustomTextButton(
                    onPressed: () {
                      bool? result = _formKey.currentState?.validate();
                      if (result == true) {
                        _launchEmail(_subject.text, _msgText.text);
                      } else {
                        showErrorDialog(context, 'Error',
                            'Please enter a valid subject and message');
                      }
                    },
                    label: const Text(
                      'Send Message',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    bg: theme.primaryColor,
                    fg: Colors.white,
                    w: 200,
                    h: 56,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
