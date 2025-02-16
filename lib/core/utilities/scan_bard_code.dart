import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanBarCode {
  late String barcode;

  // bar code scanner
  Future<String> scan(BuildContext context) async {
    // Future<void> scanBarcode() async {
    String? res = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Test',
        centerTitle: false,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back_ios),
      ),
      isShowFlashIcon: true,
      delayMillis: 2000,
      cameraFace: CameraFace.back,
    );
    barcode = res as String;
    return barcode;
    // }
  }

  String getBarCode() => barcode;
}
