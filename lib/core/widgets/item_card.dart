import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/settings/bloc/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../constance/colors.dart';
import 'custom_popup_menu_button.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String? tailing;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdite;

  const ItemCard({
    super.key,
    required this.title,
    this.subTitle = '',
    this.tailing = '',
    required this.onTap,
    required this.onDelete,
    required this.onEdite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: greyLight,
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        subTitle!,
                        maxLines: 1,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  spacing: 2,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                          return Text(
                            '${tailing!} ${state.currency}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                    // Consumer<SettingsProvider>(
                    //     builder: (context, settingsProvider, child) => Text(
                    //           '${settingsProvider.currency}',
                    //           style: TextStyle(fontWeight: FontWeight.w500),
                    //         )),
                  ],
                ),
                CustomPopupMenuButton(onDelete: onDelete, onEdite: onEdite),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
