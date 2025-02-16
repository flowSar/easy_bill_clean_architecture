
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/languge.dart';



class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  State<LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String selectedLanguage = 'en';

  @override
  void initState() {
    // selectedLanguage = context.read<SettingsProvider>().currentLocal.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      title: Text('Languages'),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      content: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: RadioMenuButton(
                  value: languages[index].language,
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value.toString();
                      print(languages[index].locale);
                    });
                    // load language
                    // context.read<SettingsProvider>().loadLanguage();
                  },
                  child: Row(
                    spacing: 20,
                    children: [
                      Icon(Icons.language),
                      Text(languages[index].name)
                    ],
                  )),
            );
          },
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              // context
              //     .read<SettingsProvider>()
              //     .changeLanguage(Locale(selectedLanguage));
              // context.read<SettingsProvider>().setLanguage(selectedLanguage);
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ),
      ],
    );
  }
}
