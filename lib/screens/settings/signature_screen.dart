import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'dart:typed_data';
import 'dart:math';

import 'package:uuid/uuid.dart';

import '../../core/widgets/custom_text_button.dart';
import '../../core/widgets/error_dialog.dart';

final random = Random();

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  late SignatureController controller;

  String? imagePath;
  File? fileImage;
  bool isDarkMode = false;

  @override
  void initState() {
    // load the them mode
    // isDarkMode = context.read<SettingsProvider>().isDarMode;
    // signature controller
    controller = SignatureController(
      penColor: isDarkMode ? Colors.white : Colors.black,
      penStrokeWidth: 3,
    );
    loadSignature();
    // assign the image signature path to the fileImage
    // fileImage = context.read<DataProvider>().signature;
    super.initState();
  }

  Future loadSignature() async {
    // load signature path from db
    // await context.read<DataProvider>().loadSignature();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // save the signature image to the deice and return its path
  Future<String> saveImage(Uint8List signature) async {
    // get the current path of the app on the device
    final directory = await getApplicationDocumentsDirectory();
    // generate file signature path
    final filePath = '${directory.path}/signature${random.nextInt(1000)}.png';
    // create the image on the device
    File file = File(filePath);
    file.writeAsBytes(signature);
    return filePath;
  }

  // function for displaying custom error dialog
  void displayError(Object e) {
    showErrorDialog(context, 'signature error', '$e');
  }

  @override
  Widget build(BuildContext context) {
    // this function will add signature image path to the database
    void addSignaturePath(String path) {
      // context.read<DataProvider>().addSignature(path);
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Signature'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          spacing: 6,
          children: [
            Signature(
              controller: controller,
              height: 180,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                CustomTextButton(
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });
                  },
                  label: Text('clear'),
                  bg: Colors.green,
                  fg: Colors.white,
                ),
                CustomTextButton(
                  onPressed: () async {
                    Uint8List? signature = await controller.toPngBytes();
                    try {
                      // get the image path after saving it to the device
                      imagePath = await saveImage(signature!);
                      // add the image path to the database and ake it available on the app with provider
                      // context.read<DataProvider>().addSignature(imagePath!);
                      addSignaturePath(imagePath!);
                      // get the image file from the imagePath
                      setState(() {
                        fileImage = File(imagePath!);
                      });
                    } catch (e) {
                      displayError(e);
                    }
                  },
                  label: Text('save'),
                  bg: Colors.green,
                  fg: Colors.white,
                ),
              ],
            ),
            if (fileImage != null)
              Image.file(
                fileImage!,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text('this signature is saved locally'))
          ],
        ),
      ),
    ));
  }
}
