import 'package:easy_bill_clean_architecture/features/data/clients/models/client_model.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/clients/bloc/client_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:uuid/uuid.dart';

import '../../../../core/constance/g_constants.dart';
import '../../../../core/constance/icons.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/widgets/client_Image.dart';
import '../../../../core/widgets/custom_badge.dart';
import '../../../../core/widgets/custom_circular_progress.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../domain/clients/model/client.dart';

const uuid = Uuid();

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  @override
  void dispose() {
    _fullName.dispose();
    _address.dispose();
    _email.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          mode == ScreenMode.navigate ? 'New Client' : 'Edit Client',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocListener<ClientBloc, ClientState>(
            listener: (context, state) {
              if (state is ClientUpdateFailed) {
                snackBar(context, 'Client update failed');
              }
              if (state is ClientUpdated) {
                snackBar(context, 'Client updated');
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // Profile Image Section
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color.fromRGBO(
                            theme.primaryColor.red,
                            theme.primaryColor.green,
                            theme.primaryColor.blue,
                            0.2,
                          ),
                          width: 2,
                        ),
                      ),
                      child: fullName == ''
                          ? Custombadge(
                              icon: kUserIcon,
                              labelIcon: Icons.image,
                              labelBg: theme.primaryColor,
                            )
                          : ClientImage(
                              cName: fullName,
                              w: 100,
                              h: 100,
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyTextType,
                    controller: _fullName,
                    placeholder: 'Enter full name',
                    title: 'Full Name',
                    validator: (name) =>
                        name!.length < 3 ? 'Please enter a valid name' : null,
                    onChanged: (value) {
                      setState(() {
                        fullName = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyTextType,
                    controller: _address,
                    placeholder: 'Enter address',
                    title: 'Address',
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyEmailType,
                    controller: _email,
                    placeholder: 'Enter email address',
                    title: 'Email',
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    readOnly: loading,
                    keyType: kKeyPhoneType,
                    controller: _phoneNumber,
                    placeholder: 'Enter phone number',
                    title: 'Phone Number',
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: CustomTextButton(
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
                              context
                                  .read<ClientBloc>()
                                  .add(AddClientEvent(client));
                              clearUserInput();
                              context.pop();
                            } else if (mode == ScreenMode.update) {
                              try {
                                context
                                    .read<ClientBloc>()
                                    .add(UpdateClientEvent(client));
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
                          ? const CustomCircularProgress()
                          : Text(
                              mode == ScreenMode.navigate
                                  ? 'Save Client'
                                  : 'Update Client',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                      w: 180,
                      h: 56,
                      bg: theme.primaryColor,
                      fg: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
