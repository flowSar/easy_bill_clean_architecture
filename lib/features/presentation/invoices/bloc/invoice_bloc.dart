import 'package:easy_bill_clean_architecture/features/domain/invoices/entities/invoice.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_event.dart';
import 'package:easy_bill_clean_architecture/features/presentation/invoices/bloc/invoice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/invoices/use_cases/invoice_use_case.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final InvoiceUseCase invoiceUseCase;

  InvoiceBloc({required this.invoiceUseCase}) : super(InvoiceInitial()) {
    on<AddInvoicesEvent>(_addInvoice);
    on<GetInvoicesEvent>(_getInvoices);
    on<DeleteInvoicesEvent>(_deleteInvoice);
  }

  Future<void> _addInvoice(
      InvoiceEvent event, Emitter<InvoiceState> emit) async {
    emit(InvoiceLoading());
    if (event is AddInvoicesEvent) {
      final List<InvoiceItem> invoiceItems = event.invoiceItems;
      final Invoice invoice = event.invoice;
      try {
        final invoiceRes =
            await invoiceUseCase.addInvoice(invoice, invoiceItems);
        invoiceRes.fold((failure) {
          return emit(InvoiceFailed('insert invoice failed: $failure'));
        }, (res) => emit(InvoiceSuccess()));
      } catch (e) {
        emit(InvoiceFailed(e.toString()));
      }
    }
  }

  Future<void> _getInvoices(
      InvoiceEvent event, Emitter<InvoiceState> emit) async {
    try {
      emit(InvoiceLoading());
      // first load the invoices
      final result = await invoiceUseCase.getInvoices();
      result.fold((failure) => emit(InvoiceFailed(failure.error)),
          (invoices) async {
        // if the invoice succeed load the invoiceItem
        emit(InvoicesLoaded(invoices: invoices));
      });
    } catch (e) {
      emit(InvoiceFailed(e.toString()));
    }
  }

  Future<void> _deleteInvoice(
      InvoiceEvent event, Emitter<InvoiceState> emit) async {
    try {
      if (event is DeleteInvoicesEvent) {
        final result = await invoiceUseCase.deleteInvoice(event.invoiceId);
        result.fold((failure) {}, (res) {
          if (res == 1) {
            emit(InvoiceSuccess());
          } else {
            emit(InvoiceFailed('delete invoice failed result: $result'));
          }
        });
      }
    } catch (e) {
      emit(InvoiceFailed(e.toString()));
    }
  }
}
