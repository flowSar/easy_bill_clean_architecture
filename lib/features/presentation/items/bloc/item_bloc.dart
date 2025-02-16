import 'package:easy_bill_clean_architecture/core/use_case/item_use_case.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/items/bloc/item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemUseCases itemUseCases;

  ItemBloc({required this.itemUseCases}) : super(ItemInitialState()) {
    on<AddItemEvent>(_addItem);
    on<GetItemEvent>(_getItems);
  }

  void _addItem(ItemEvent event, Emitter<ItemState> emit) async {
    try {
      final item = (event as AddItemEvent).item;
      final result = await itemUseCases.addItem(item);
      result.fold((failure) {
        emit(ItemFailedState(failure.error));
      }, (int res) {
        if (res == 0) {
          emit(ItemFailedState('adding the item failed'));
        } else {
          emit(ItemSuccessState());
        }
      });
    } catch (e) {
      emit(ItemFailedState(e.toString()));
    }
  }

  void _getItems(ItemEvent event, Emitter<ItemState> emit) async {
    try {
      emit(ItemLoadingState());
      final result = await itemUseCases.getItems();
      result.fold((failure) {
        emit(ItemFailedState(failure.error));
      }, (items) {
        emit(ItemLoadedState(items));
      });
    } catch (e) {
      emit(ItemFailedState(e.toString()));
    }
  }
}
