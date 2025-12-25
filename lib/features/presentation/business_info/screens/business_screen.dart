import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/business_info/bloc/business_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../domain/business_info/entity/business_info_entity.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _businessName = TextEditingController();
    _businessAddress = TextEditingController();
    _businessEmail = TextEditingController();
    _businessPhoneNumber = TextEditingController();
    loadBusinessInfo();
    super.initState();
  }

  @override
  void dispose() {
    _businessName.dispose();
    _businessAddress.dispose();
    _businessEmail.dispose();
    _businessPhoneNumber.dispose();
    super.dispose();
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Business',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: BlocListener<BusinessInfoBloc, BusinessInfoState>(
        listener: (context, state) {
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
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    title: 'Business Name',
                    keyType: kKeyTextType,
                    controller: _businessName,
                    placeholder: 'Enter business name',
                    validator: (val) =>
                        val!.length < 3 ? 'Please enter business name' : null,
                    onErase: () => _businessName.clear(),
                  ),
                  CustomTextField(
                    title: 'Address',
                    keyType: kKeyTextType,
                    controller: _businessAddress,
                    placeholder: 'Enter business address',
                    onErase: () => _businessAddress.clear(),
                  ),
                  CustomTextField(
                    title: 'Email',
                    keyType: kKeyEmailType,
                    controller: _businessEmail,
                    placeholder: 'Enter business email',
                    onErase: () => _businessEmail.clear(),
                  ),
                  CustomTextField(
                    title: 'Phone Number',
                    keyType: kKeyNumberType,
                    controller: _businessPhoneNumber,
                    placeholder: 'Enter phone number',
                    onErase: () => _businessPhoneNumber.clear(),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: CustomTextButton(
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
                            if (_businessInfoId == 0) {
                              try {
                                context.read<BusinessInfoBloc>().add(
                                      AddBusinessInfoEvent(
                                          businessInfo: businessInfo),
                                    );
                                displaySnackBar(
                                    'Business info added successfully');
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
                                    'Business info updated successfully');
                              } catch (e) {
                                displayErrorDialog(e.toString());
                              }
                            }
                          }
                        } catch (e) {
                          displayErrorDialog(e);
                        }
                      },
                      label: Text(
                        _businessInfoId != 0
                            ? 'Update Business'
                            : 'Save Business',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      bg: theme.primaryColor,
                      fg: Colors.white,
                      w: 200,
                      h: 56,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
