import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constance/styles.dart';
import '../../../../core/models/business_info.dart';
import '../../../../core/models/invoice.dart';
import '../../../../core/utilities/generate_pdf.dart';
import '../../../../core/widgets/bill_table_row.dart';
import '../../../../core/widgets/error_dialog.dart';

const kTableHeadTextStyle = TextStyle(fontSize: 15, color: Colors.white);

class PreviewInvoiceScreen extends StatelessWidget {
  final GeneralInvoice? invoice;

  const PreviewInvoiceScreen({super.key, this.invoice});

  BusinessInfo? get businessInfo => null;

  @override
  Widget build(BuildContext context) {
    // pop up when this function called
    void returnBack() {
      Navigator.of(context).pop();
    }

    // display error dialog
    void showError(Object e) {
      showErrorDialog(context, 'Error', '$e');
    }

    // display error dialog
    void displayErrorDialog(String e) {
      showErrorDialog(context, 'Error', e);
    }

    // String currency = context.read<SettingsProvider>().currency;
    String currency = '';
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
              try {
                // await context.read<DataProvider>().deleteInvoice(invoice!.id);
                returnBack();
              } catch (e) {
                showError(e);
              }
            },
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 12,
              ),
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Consumer<DataProvider>(
                      //     builder: (context, dataProvider, child) {
                      //   return Text(
                      //     dataProvider.businessInfo!.businessName,
                      //     style: kTextStyle2b.copyWith(fontSize: 26),
                      //   );
                      // }),
                      Text(
                        'Invoice#',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Invoice To',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18)),
                          Text(
                            '${invoice?.clientName}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${invoice?.clientEmail}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${invoice?.clientPhoneNumber}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 4,
                        children: [
                          Text(
                            'Invoice NB: ${invoice?.billNumber}',
                          ),
                          Text('created at: ${invoice?.billDate}'),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Description',
                              style: kTableHeadTextStyle,
                              maxLines: 1,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'QTY',
                              style: kTableHeadTextStyle,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Price',
                              style: kTableHeadTextStyle,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Tax',
                              style: kTableHeadTextStyle,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'total',
                              style: kTableHeadTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: invoice?.items.length,
                  itemBuilder: (context, index) {
                    return BillTableRow(
                        product: invoice!.items[index].name,
                        quantity: invoice!.items[index].quantity.toString(),
                        price: invoice!.items[index].price.toString(),
                        total: invoice!.items[index].total.toString(),
                        tax: invoice!.items[index].tax.toString());
                  }),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                // color: Colors.amber,
                border: Border.all(),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Total: ${invoice?.total} $currency',
                  textAlign: TextAlign.center,
                  style: kTextStyle2b,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // BusinessInfo? businessInfo =
                  //     context.read<DataProvider>().businessInfo;
                  // File? signatureFile = context.read<DataProvider>().signature;
                  File? signatureFile = null;
                  PdfGenerator(currency);

                  if (signatureFile == null) {
                    displayErrorDialog('Please add Your signature');
                  } else {
                    final pdfFile = await PdfGenerator.generatePdf(
                      invoice!,
                      businessInfo,
                      signatureFile,
                    );
                    PdfGenerator.openFile(pdfFile);
                  }
                } catch (e) {
                  displayErrorDialog(e.toString());
                }
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  )),
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 4),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Text(
                      'Save as Pdf',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
