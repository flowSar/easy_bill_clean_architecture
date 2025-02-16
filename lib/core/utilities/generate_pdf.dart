import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

import '../models/business_info.dart';
import '../models/invoice.dart';

// this class will generate a pdf bill from the data that will be provide to him
class PdfGenerator {
  static String currency = '\$';

  PdfGenerator(String cur) {
    currency = cur;
  }

  // save the paf file to the device so we can use external app to display it
  static Future<File> saveDocument(String name, Document pdf) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  // open the pdf file externally
  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Future<File> generatePdf(GeneralInvoice bill,
      BusinessInfo? businessInfo, File signatureFile) async {
    final fontRegular =
        pw.Font.ttf(await rootBundle.load('fonts/Roboto-Regular.ttf'));
    final fontBold =
        pw.Font.ttf(await rootBundle.load('fonts/Roboto-Bold.ttf'));

    final pdf = Document();
    // Future<Uint8List> getFileBytes(String path) async {
    //   final file = File(path);
    //   return await file.readAsBytes();
    // }

    final Uint8List imageBytes = await signatureFile.readAsBytes();
    final signatureImage = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                businessInfo?.businessName ?? 'Anonymous',
                style:
                    pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pw.Text('invoice To:',
                              style: pw.TextStyle(font: fontRegular)),
                          pw.SizedBox(height: 6),
                          pw.Text(bill.clientName,
                              style: pw.TextStyle(font: fontRegular)),
                          pw.SizedBox(height: 6),
                          pw.Text(bill.clientEmail,
                              style: pw.TextStyle(font: fontRegular)),
                          pw.SizedBox(height: 6),
                          pw.Text(bill.clientPhoneNumber,
                              style: pw.TextStyle(font: fontRegular)),
                        ]),
                    pw.Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pw.Text('invoice#: ${bill.billNumber}',
                              style: pw.TextStyle(font: fontRegular)),
                          pw.SizedBox(height: 6),
                          pw.Text('Date: ${bill.billDate}',
                              style: pw.TextStyle(font: fontRegular)),
                        ]),
                  ]),
              pw.Divider(),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                      decoration: BoxDecoration(
                        color: PdfColor.fromHex('#E4DADA'),
                      ),
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text('Product',
                              style: pw.TextStyle(font: fontBold)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text('Quantity',
                              style: pw.TextStyle(font: fontBold)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text('Price',
                              style: pw.TextStyle(font: fontBold)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text('Tax',
                              style: pw.TextStyle(font: fontBold)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text('subTotal',
                              style: pw.TextStyle(font: fontBold)),
                        ),
                      ]),
                  ...bill.items.map((item) {
                    double subTotal = item.price * item.quantity;
                    double tax = item.tax!;
                    double taxValue = (subTotal * tax) / 100;
                    return pw.TableRow(children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text(item.name ?? '',
                            style: pw.TextStyle(font: fontRegular)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text(item.quantity.toString(),
                            style: pw.TextStyle(font: fontRegular)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text(item.price.toString(),
                            style: pw.TextStyle(font: fontRegular)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text('$taxValue (${item.tax.toString()}%)',
                            style: pw.TextStyle(font: fontRegular)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.Text(item.total.toString(),
                            style: pw.TextStyle(font: fontRegular)),
                      ),
                    ]);
                  }).toList(),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  'Total: ${bill.total} $currency',
                  style: pw.TextStyle(font: fontBold, fontSize: 18),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.Row(children: [
                pw.Text('Email: ${businessInfo?.businessEmail}'),
                pw.Text(' / phone: ${businessInfo?.businessPhoneNumber}'),
                pw.Text(' / address: ${businessInfo?.businessAddress}'),
              ]),
              pw.SizedBox(height: 14),
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    Column(children: [
                      pw.Text('Signature'),
                      pw.SizedBox(height: 10),
                      pw.Image(signatureImage, height: 40, width: 40),
                    ])
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    return saveDocument(
        'invoices${bill.clientName}-${bill.billNumber}.pdf', pdf);
  }
}
