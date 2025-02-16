import 'package:easy_bill_clean_architecture/features/domain/items/entity/item.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_bloc.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constance/colors.dart';
import '../../../../core/constance/g_constants.dart';
import '../../../../core/utilities/functions.dart';
import '../../../../core/widgets/custom_Floating_button.dart';
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
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Items'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            CustomTextField(
              controller: _searchKeyWord,
              bg: kTextInputBg1,
              placeholder: 'Search item name',
              title: 'Item Name',
              icon: Icon(Icons.search),
              onChanged: (value) {
                setState(() {
                  // dataProvider.flitterLists(value, 'items');
                });
              },
              onErase: () {
                // dataProvider.flitterLists('', 'items');
                // setState(() {
                //   _searchKeyWord.text = '';
                // });
              },
            ),
            BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is ItemFailedState) {
                  return Text('loading items failed : ${state.error}');
                }
                if (state is ItemLoadingState) {
                  return CustomCircularProgress(
                    w: 100,
                    h: 100,
                    strokeWidth: 6,
                  );
                }
                if (state is ItemLoadedState) {
                  items = state.items;
                }
                return Expanded(
                  child: items.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: loadItemsData,
                          child: ListView.builder(
                              padding: EdgeInsets.only(bottom: height * 0.085),
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
                                    try {
                                      // context.read<DataProvider>().deleteItem(
                                      //       items[index].id!,
                                      //     );
                                      displaySnackBar(
                                          'the Item was created successfully');
                                    } catch (e) {
                                      showErrorDialog(
                                          context, "error", e.toString());
                                    }
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
                              }),
                        )
                      : SingleChildScrollView(
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.7,
                            child: Empty(
                              title: 'No Items was found',
                              subTitle:
                                  'tap on Button Below to Create New Item',
                              btnLabel: 'add New item',
                              onPressed: () => context.push(
                                '/newItemScreen',
                                extra: ItemScreenParams(
                                  item: null,
                                  mode: ScreenMode.navigate,
                                ),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        w: 120,
        onPressed: () {
          context
              .push(
            '/newItemScreen',
            extra: ItemScreenParams(
              item: null,
              mode: ScreenMode.navigate,
            ),
          )
              .then((returnedItem) {
            if (returnedItem != null) {
              Item item = returnedItem as Item;
              setState(() {
                items.add(item);
              });
            }
          });
        },
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
            Text(
              'New Item',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
