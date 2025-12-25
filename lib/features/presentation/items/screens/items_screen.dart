import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/widgets/custom_circular_progress.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/empty.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/item_card.dart';
import '../bloc/item_event.dart';

class ItemsScreen extends StatefulWidget {
  final ScreenMode mode;

  const ItemsScreen({super.key, required this.mode});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  late final TextEditingController _searchKeyWord;
  List<Item> items = [];

  // List<Item> items = [
  //   Item(
  //       barCode: '0987654543',
  //       description: 'Signal Nature Elements Toothbrush with Baking Soda MP 2',
  //       name: 'signal',
  //       price: 12.5,
  //       quantity: 10),
  // ];
  @override
  void initState() {
    // load all item from the database
    _searchKeyWord = TextEditingController();
    loadItemsData();
    super.initState();
  }

  Future<void> loadItemsData() async {
    try {
      // load all item from database
      context.read<ItemBloc>().add(GetItemEvent());
    } catch (e) {
      showErrorDialog(context, 'loading Items', e.toString());
    }
  }

  // display snack bar
  void displaySnackBar(String msg) {
    snackBar(context, msg);
  }

  @override
  void dispose() {
    _searchKeyWord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Items',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: CustomTextField(
              controller: _searchKeyWord,
              placeholder: 'Search item name',
              title: 'Item',
              icon: Icon(Icons.search_rounded, color: theme.primaryColor),
              onChanged: (keyWord) {
                context.read<ItemBloc>().add(FilterItemsEvent(name: keyWord));
              },
              onErase: () {
                context.read<ItemBloc>().add(FilterItemsEvent(name: ''));
                setState(() {
                  _searchKeyWord.text = '';
                });
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<ItemBloc, ItemState>(
              listener: (context, state) {
                if (state is ItemAdded ||
                    state is ItemUpdated ||
                    state is ItemDeleted) {
                  context.read<ItemBloc>().add(GetItemEvent());
                  if (state is ItemAdded)
                    displaySnackBar('Item created successfully');
                  if (state is ItemUpdated)
                    displaySnackBar('Item updated successfully');
                  if (state is ItemDeleted)
                    displaySnackBar('Item deleted successfully');
                }
              },
              builder: (context, state) {
                if (state is ItemLoadingState) {
                  return const Center(child: CustomCircularProgress());
                }
                if (state is ItemFailedState) {
                  return Center(
                      child: Text('Loading items failed: ${state.error}'));
                }
                if (state is ItemDeletedFailed) {
                  showErrorDialog(context, 'Delete Item', 'Delete Item Failed');
                }
                if (state is ItemLoadedState) {
                  items = state.items;
                }

                if (items.isEmpty) {
                  return Center(
                    child: Empty(
                      title: 'No items found',
                      subTitle: 'Tap the button below to create a new item',
                      btnLabel: 'Add New Item',
                      onPressed: () => context.push(
                        '/newItemScreen',
                        extra: ItemScreenParams(
                          item: null,
                          mode: ScreenMode.navigate,
                        ),
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: loadItemsData,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80, top: 4),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ItemCard(
                        title: items[index].name,
                        subTitle: items[index].description,
                        tailing: items[index].price.toString(),
                        onTap: () {
                          Item currentItem = items[index];
                          if (widget.mode == ScreenMode.select) {
                            context.pop(currentItem);
                          } else {
                            context.push(
                              '/newItemScreen',
                              extra: ItemScreenParams(
                                item: currentItem,
                                mode: ScreenMode.update,
                              ),
                            );
                          }
                        },
                        onDelete: () {
                          context
                              .read<ItemBloc>()
                              .add(DeleteItemEvent(id: items[index].id!));
                        },
                        onEdite: () {
                          Item currentItem = items[index];
                          context.push(
                            '/newItemScreen',
                            extra: ItemScreenParams(
                              item: currentItem,
                              mode: ScreenMode.update,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(
            '/newItemScreen',
            extra: ItemScreenParams(
              item: null,
              mode: ScreenMode.navigate,
            ),
          );
        },
        label: const Text('New Item',
            style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_rounded),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
