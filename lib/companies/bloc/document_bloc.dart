import 'dart:io';

import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_bloc.freezed.dart';
part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc(this._accountingRepository) : super(const DocumentState()) {
    on<DocumentCreateRequested>(_onIncomeCreateRequested);
    on<DocumentGetRequested>(_onIncomeGetRequested);
    // on<DocumentDeleteRequested>(_onIncomeDeleteRequested);
  }

  final AccountingRepository _accountingRepository;

  Future _onIncomeCreateRequested(
    DocumentCreateRequested event,
    Emitter<DocumentState> emit,
  ) async {
    emit(state.copyWith(
      action: DocumentAction.create,
      status: DocumentStatus.loading,
    ));
    var response = await _accountingRepository.createDocument(
        companyId: event.companyId, document: event.document);
    if (response.status) {
      emit(state.copyWith(
        action: DocumentAction.create,
        status: DocumentStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: DocumentAction.create,
        status: DocumentStatus.failure,
        message: response.message,
      ));
    }
  }

  Future _onIncomeGetRequested(
    DocumentGetRequested event,
    Emitter<DocumentState> emit,
  ) async {
    emit(state.copyWith(
      action: DocumentAction.get,
      status: DocumentStatus.loading,
    ));
    var response = await _accountingRepository.getDocuments(
      companyId: event.companyId,
    );
    if (response.status) {
      emit(state.copyWith(
        action: DocumentAction.get,
        list: response.data!,
        status: DocumentStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: DocumentAction.get,
        status: DocumentStatus.failure,
      ));
    }
  }

  // Future _onIncomeDeleteRequested(
  //   DocumentDeleteRequested event,
  //   Emitter<DocumentState> emit,
  // ) async {
  //   emit(state.copyWith(
  //     action: DocumentAction.delete,
  //     status: DocumentStatus.loading,
  //   ));
  //   var response = await _accountingRepository.delete(id: event.id);
  //   if (response.status) {
  //     emit(state.copyWith(
  //       action: DocumentAction.delete,
  //       status: DocumentStatus.success,
  //       message: response.message,
  //     ));
  //   } else {
  //     emit(state.copyWith(
  //       action: DocumentAction.delete,
  //       status: DocumentStatus.failure,
  //     ));
  //   }
  // }
}
