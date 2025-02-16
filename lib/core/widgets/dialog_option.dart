import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  final Widget title;
  final Widget content;
  final VoidCallback? yesFunction;
  final VoidCallback? noFunction;

  const DialogOption({
    super.key,
    required this.title,
    required this.content,
    this.yesFunction,
    this.noFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titlePadding: EdgeInsets.only(top: 10, left: 10, right: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      content: SizedBox(
        height: 38,
        child: content,
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      actions: [
        TextButton(
          onPressed: yesFunction,
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: noFunction,
          child: Text('No'),
        ),
      ],
    );
  }
}
