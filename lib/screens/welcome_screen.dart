
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SettingsProvider language = context.watch<SettingsProvider>();
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('images/EasyBill.png')),
            Text(
              'welcome msg',
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/bottomNavBar');
              },
              child: Text('Get started'),
            ),
          ],
        ),
      ),
    ));
  }
}
