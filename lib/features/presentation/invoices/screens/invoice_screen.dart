import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool loading = false;
  late bool isSearching = false;
  late TextEditingController searchKeyword;

  @override
  void initState() {
    loadInvoices();
    searchKeyword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchKeyword.dispose();
    super.dispose();
  }

  // load all bills from database
  Future loadInvoices() async {
    try {
      // set loading state to true when this function called
      setState(() {
        loading = true;
      });
      // start loading data from database
      // await context.read<DataProvider>().loadInvoices();
      // set loading to false data after data loading finished
      loading = false;
    } catch (e) {
      // set loading to false if loading failed and display the error
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // SettingsProvider language = context.watch<SettingsProvider>();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Invoices'),
        actions: [
          // if the use click on the search icon we open the search bar
          isSearching
              ? Row(
                  spacing: 14,
                  children: [
                    InkWell(
                      onTap: () {
                        searchKeyword.clear();
                        loadInvoices();
                        setState(() {
                          // set the searching state to false to hide the search bar
                          isSearching = false;
                        });
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 260,
                      child: TextField(
                        controller: searchKeyword,
                        decoration: InputDecoration(
                          hintText: 'Search (client name)',
                          border: InputBorder.none,
                        ),
                        onChanged: (key) {
                          // context.read<DataProvider>().filterInvoices(key);
                        },
                      ),
                    ),
                  ],
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.filter_alt,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: Text('empty')
              //     Consumer<DataProvider>(builder: (context, dataProvider, child) {
              //   List<GeneralInvoice> bills = dataProvider.invoices;
              //   // if loading = true , display loading widget
              //   if (loading) {
              //     return Center(
              //       child: CustomCircularProgress(
              //         w: 120,
              //         h: 120,
              //         strokeWidth: 4,
              //       ),
              //     );
              //   } else {
              //     // if the bills 1= []display bills
              //     if (bills.isNotEmpty) {
              //       return ListView.builder(
              //         itemCount: bills.length,
              //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              //         itemBuilder: (context, index) {
              //           return GestureDetector(
              //             onTap: () {
              //               context.push('/previewBillScreen',
              //                   extra: bills[index]);
              //             },
              //             child: BillCard(
              //               client: bills[index].clientName,
              //               date: bills[index].billDate,
              //               total: bills[index].total.toString(),
              //               billNumber: formatNumber(index + 1),
              //             ),
              //           );
              //         },
              //       );
              //     } else {
              //       // we display two kind of design if the use is searching fo an invoice and didn't found it
              //       // and when there's no invoice if the database
              //       return Center(
              //         child: isSearching
              //             ? Text('No invoice Was found try another key word')
              //             : Empty(
              //                 title: language.translate('No invoice Was found'),
              //                 subTitle: ''),
              //       );
              //     }
              //   }
              // }),
              ),
        ],
      ),
    ));
  }
}
