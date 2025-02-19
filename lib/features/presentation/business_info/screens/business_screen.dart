import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constance/colors.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../domain/business_info/entity/business_info_entity.dart';

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
  late BusinessInfo? businessInfo;

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
    try {
      // load business info from database and make this info available through the app
      // await context.read<DataProvider>().loadBusinessInfo();
      context.read<BusinessInfoBloc>().add(GetBusinessInfoEvent());
    } catch (e) {
      showErrorDialog(context, 'loading business info', e.toString());
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Business'),
        leading: InkWell(
            onTap: () {
              context.pop(context);
            },
            child: Icon(Icons.close)),
      ),
      body: BlocListener<BusinessInfoBloc, BusinessInfoState>(
        listener: (context, state) {
          // if (state is BusinessInfoLoading) {
          //   return CustomCircularProgress(
          //     w: 120,
          //     h: 120,
          //     strokeWidth: 4,
          //   );
          // }
          // if (state is BusinessInfoUpdateFailed) {
          //   return Center(
          //     child: Text('Update businessInfo failed: ${state.error}'),
          //   );
          // }
          if (state is BusinessInfoLoaded) {
            businessInfo = state.businessInfo;
            if (businessInfo != null) {
              setState(() {
                _businessInfoId = businessInfo!.id!;
                _businessEmail.text = businessInfo!.businessEmail!;
                _businessName.text = businessInfo!.businessName;
                _businessAddress.text = businessInfo!.businessAddress!;
                _businessPhoneNumber.text = businessInfo!.businessPhoneNumber!;
              });
            }
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    title: 'Business Name',
                    keyType: kKeyTextType,
                    // initialValue: 'sar',
                    controller: _businessName,
                    bg: kTextInputBg1,
                    placeholder: 'Business name',
                    validator: (businessNam) => businessNam!.length < 3
                        ? 'please Insert business name'
                        : null,
                  ),
                  CustomTextField(
                    title: 'Address',
                    keyType: kKeyTextType,
                    controller: _businessAddress,
                    bg: kTextInputBg1,
                    placeholder: 'Business address',
                  ),
                  CustomTextField(
                    title: 'Email',
                    keyType: kKeyEmailType,
                    controller: _businessEmail,
                    bg: kTextInputBg1,
                    placeholder: 'Business email address',
                  ),
                  CustomTextField(
                    title: 'Phone Number',
                    keyType: kKeyNumberType,
                    controller: _businessPhoneNumber,
                    bg: kTextInputBg1,
                    placeholder: 'Business phone number',
                  ),
                  CustomTextButton(
                      onPressed: () async {
                        try {
                          bool? valid = _formKey.currentState?.validate();
                          if (valid == true) {
                            BusinessInfo businessInfo = BusinessInfo(
                              id: _businessInfoId,
                              businessName: _businessName.text,
                              businessAddress: _businessAddress.text,
                              businessEmail: _businessEmail.text,
                              businessPhoneNumber: _businessPhoneNumber.text,
                            );
                            // print(businessInfo.businessAddress);
                            if (_businessInfoId == 0) {
                              try {
                                context.read<BusinessInfoBloc>().add(
                                      AddBusinessInfoEvent(
                                          businessInfo: businessInfo),
                                    );
                                displaySnackBar(
                                    'the business info was added successfully');
                              } catch (e) {
                                displayErrorDialog(e.toString());
                              }
                            } else {
                              try {
                                context.read<BusinessInfoBloc>().add(
                                      UpdateBusinessInfoEvent(
                                          businessInfo: businessInfo),
                                    );
                                displaySnackBar(
                                    'the business info was updated successfully');
                              } catch (e) {
                                displayErrorDialog(e.toString());
                              }
                            }
                          }
                        } catch (e) {
                          displayErrorDialog(e);
                        }
                      },
                      label:
                          _businessInfoId == 1 ? Text('update') : Text('Save'),
                      bg: Colors.green,
                      fg: Colors.white,
                      w: 120,
                      h: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
