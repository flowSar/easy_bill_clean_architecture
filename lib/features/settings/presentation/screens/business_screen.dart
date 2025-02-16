import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constance/colors.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/widgets/custom_circular_progress.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';

final _formKey = GlobalKey<FormState>();

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  late final TextEditingController _businessName;
  late final TextEditingController _businessAddress;
  late final TextEditingController _businessEmail;
  late final TextEditingController _businessPhoneNumber;
  late var _businessInfoId = 0;
  bool loading = false;

  @override
  void initState() {
    _businessName = TextEditingController();
    _businessAddress = TextEditingController();
    _businessEmail = TextEditingController();
    _businessPhoneNumber = TextEditingController();

    loadBusinessInfo();
    super.initState();
  }

  Future loadBusinessInfo() async {
    setState(() {
      loading = true;
    });
    try {
      // load business info from database and make this info available through the app
      // await context.read<DataProvider>().loadBusinessInfo();
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  void displayErrorDialog(Object e) {
    showErrorDialog(context, 'Error', e.toString());
  }

  void displaySnackBar(String msg) {
    snackBar(context, msg);
  }

  @override
  Widget build(BuildContext context) {
    return Text('empty');
  }
// return Consumer<DataProvider>(builder: (context, dataProvider, child) {
//   if (loading) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Business'),
//         leading: InkWell(
//             onTap: () {
//               context.pop();
//             },
//             child: Icon(Icons.close)),
//       ),
//       body: Center(
//         child: CustomCircularProgress(
//           w: 120,
//           h: 120,
//           strokeWidth: 4,
//         ),
//       ),
//     );
//   } else {
//     BusinessInfo? businessInfo = dataProvider.businessInfo;
//     if (businessInfo != null) {
//       _businessInfoId = businessInfo.id;
//       _businessEmail.text = businessInfo.businessEmail!;
//       _businessName.text = businessInfo.businessName;
//       _businessAddress.text = businessInfo.businessAddress!;
//       _businessPhoneNumber.text = businessInfo.businessPhoneNumber!;
//     }
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(
//         title: Text('Your Business'),
//         leading: InkWell(
//             onTap: () {
//               context.pop();
//             },
//             child: Icon(Icons.close)),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: EdgeInsets.all(10),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CustomTextField(
//                   title: 'Business Name',
//                   keyType: kKeyTextType,
//                   // initialValue: 'sar',
//                   controller: _businessName,
//                   bg: kTextInputBg1,
//                   placeholder: 'Business name',
//                   validator: (businessNam) => businessNam!.length < 3
//                       ? 'please Insert business name'
//                       : null,
//                 ),
//                 CustomTextField(
//                   title: 'Address',
//                   keyType: kKeyTextType,
//                   controller: _businessAddress,
//                   bg: kTextInputBg1,
//                   placeholder: 'Business address',
//                 ),
//                 CustomTextField(
//                   title: 'Email',
//                   keyType: kKeyEmailType,
//                   controller: _businessEmail,
//                   bg: kTextInputBg1,
//                   placeholder: 'Business email address',
//                 ),
//                 CustomTextField(
//                   title: 'Phone Number',
//                   keyType: kKeyNumberType,
//                   controller: _businessPhoneNumber,
//                   bg: kTextInputBg1,
//                   placeholder: 'Business phone number',
//                 ),
//                 CustomTextButton(
//                     onPressed: () async {
//                       try {
//                         bool? valid = _formKey.currentState?.validate();
//                         if (valid == true) {
//                           BusinessInfo businessInfo = BusinessInfo(
//                             id: _businessInfoId,
//                             businessName: _businessName.text,
//                             businessAddress: _businessAddress.text,
//                             businessEmail: _businessEmail.text,
//                             businessPhoneNumber: _businessPhoneNumber.text,
//                           );
//                           // print(businessInfo.businessAddress);
//                           if (_businessInfoId == 0) {
//                             try {
//                               // await context
//                               //     .read<DataProvider>()
//                               //     .addBusinessInfo(businessInfo);
//                               displaySnackBar(
//                                   'the business info was added successfully');
//                             } catch (e) {
//                               displayErrorDialog(e.toString());
//                             }
//                           } else {
//                             try {
//                               // await context
//                               //     .read<DataProvider>()
//                               //     .updateBusinessInfo(businessInfo);
//                               displaySnackBar(
//                                   'the business info was updated successfully');
//                             } catch (e) {
//                               displayErrorDialog(e.toString());
//                             }
//                           }
//                         }
//                       } catch (e) {
//                         displayErrorDialog(e);
//                       }
//                     },
//                     label: _businessInfoId == 1
//                         ? Text('update')
//                         : Text('Save'),
//                     bg: Colors.green,
//                     fg: Colors.white,
//                     w: 120,
//                     h: 50),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// });
// }
}
