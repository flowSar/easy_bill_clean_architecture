import 'package:easy_bill_clean_architecture/features/data/clients/models/client_model.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constance/colors.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/constance/icons.dart';
import '../../../../core/constance/styles.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/widgets/client_Image.dart';
import '../../../../core/widgets/custom_badge.dart';
import '../../../../core/widgets/custom_circular_progress.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../domain/clients/model/client.dart';

final _formKey = GlobalKey<FormState>();
var uuid = Uuid();

class NewClientScreen extends StatefulWidget {
  final Client? client;
  final ScreenMode mode;

  const NewClientScreen({super.key, this.client, required this.mode});

  @override
  State<NewClientScreen> createState() => _NewClientScreenState();
}

class _NewClientScreenState extends State<NewClientScreen> {
  late final TextEditingController _fullName;
  late String fullName = '';
  late final TextEditingController _address;
  late final TextEditingController _email;
  late final TextEditingController _phoneNumber;
  int? clientId;
  bool loading = false;
  late final ScreenMode mode;

  @override
  void initState() {
    _fullName = TextEditingController();
    _address = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();
    mode = widget.mode;

    if (widget.client != null) {
      clientId = widget.client!.id;
      _fullName.text = widget.client!.fullName;
      _address.text = widget.client!.address ?? '';
      _email.text = widget.client!.email ?? '';
      _phoneNumber.text = widget.client!.phoneNumber ?? '';
      fullName = widget.client!.fullName;
    }
    super.initState();
  }

  // display Error dialog
  void displayErrorDialog(Object error) {
    showErrorDialog(context, 'Error', error);
  }

  // i get error after I leas this screen saying the TextField is being used after being disposed.
  // that why I removed the dispose from here and I did add it to the CustomTextField component
  // @override
  // void dispose() {
  //   _fullName.dispose();
  //   _email.dispose();
  //   _fullName.dispose();
  //   _address.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    void displaySnackBar(String msg) {
      snackBar(context, msg);
    }

    // clear user input
    void clearUserInput() {
      _fullName.clear();
      _address.clear();
      _email.clear();
      _phoneNumber.clear();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('New Client'),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.close)),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // change the icons of the client based on the client fullName
                  fullName == ''
                      ? Custombadge(
                          icon: kUserIcon,
                          labelIcon: Icons.image,
                          labelBg: Colors.blueGrey,
                        )
                      : ClientImage(
                          cName: fullName,
                          w: 90,
                          h: 90,
                        ),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyTextType,
                    controller: _fullName,
                    placeholder: 'Full Name',
                    title: 'fullName',
                    bg: kTextInputBg1,
                    validator: (name) =>
                        name!.length < 3 ? 'Please Insert valid Input' : null,
                    onChanged: (value) {
                      setState(() {
                        fullName = value;
                      });
                    },
                  ),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyTextType,
                    controller: _address,
                    placeholder: 'Address',
                    title: 'Address',
                    bg: kTextInputBg1,
                  ),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyEmailType,
                    controller: _email,
                    placeholder: 'Email',
                    title: 'Email',
                    bg: kTextInputBg1,
                  ),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyPhoneType,
                    controller: _phoneNumber,
                    placeholder: 'Phone number',
                    title: 'phoneNumber',
                    bg: kTextInputBg1,
                  ),
                  CustomTextButton(
                    onPressed: () async {
                      Client client = Client(
                        id: clientId,
                        fullName: _fullName.text.trim(),
                        address: _address.text.trim(),
                        email: _email.text.trim(),
                        phoneNumber: _phoneNumber.text.trim(),
                      );
                      // validate use input
                      bool? valid = _formKey.currentState?.validate();
                      if (valid == true) {
                        try {
                          setState(() {
                            loading = true;
                          });
                          if (mode == ScreenMode.navigate) {
                            // add client to the database
                            context
                                .read<ClientBloc>()
                                .add(AddClientEvent(client));
                            displaySnackBar(
                                'The client was added successfully');
                            clearUserInput();
                          } else if (mode == ScreenMode.update) {
                            try {
                              context
                                  .read<ClientBloc>()
                                  .add(UpdateClientEvent(client));
                              displaySnackBar(
                                  'The client was updated successfully');
                            } catch (e) {
                              displayErrorDialog(e);
                            }
                          } else {
                            displayErrorDialog('wrong screen mode');
                          }

                          setState(() {
                            loading = false;
                          });
                        } catch (e) {
                          setState(() {
                            loading = false;
                          });
                          displayErrorDialog(e);
                        }
                      }
                    },
                    label: loading
                        ? CustomCircularProgress()
                        : Text(
                            mode == ScreenMode.navigate ? 'save' : 'update',
                            style: kTextStyle2b,
                          ),
                    w: 120,
                    h: 50,
                    bg: Colors.green,
                    fg: Colors.white,
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
