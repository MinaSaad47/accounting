import 'dart:io';

import 'package:accounting/utils/utils.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

part 'document_bloc.freezed.dart';
part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc(this._accountingRepository) : super(const DocumentState()) {
    on<DocumentCreateRequested>(_onDocumentCreateRequested);
    on<DocumentGetRequested>(_onDocumentGetRequested);
    on<DocumentRetreiveRequested>(_onDocumentRetreiveRequested);
    on<DocumentDeleteRequested>(_onDocumentDeleteRequested);
  }

  final AccountingRepository _accountingRepository;

  Future _onDocumentCreateRequested(
    DocumentCreateRequested event,
    Emitter<DocumentState> emit,
  ) async {
    var path = await FilePicker.platform
        .pickFiles()
        .then((value) => value?.paths.first);

    if (path == null) return;

    emit(state.copyWith(
      action: DocumentAction.create,
      status: DocumentStatus.loading,
    ));
    var response = await _accountingRepository.createDocument(
      companyId: event.companyId,
      document: File(path),
      onProgress: event.onProgress,
    );
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

  Future _onDocumentGetRequested(
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

  Future _onDocumentRetreiveRequested(
    DocumentRetreiveRequested event,
    Emitter<DocumentState> emit,
  ) async {
    emit(state.copyWith(
      action: DocumentAction.retreive,
      status: DocumentStatus.loading,
    ));

    try {
      var retreived = await _accountingRepository.retreiveDocument(
        path: event.path,
        onProgress: event.onProgress,
      );

      var dir = await FilePicker.platform.getDirectoryPath();
      if (dir != null) {
        var newPath = join(dir, basename(retreived.path));
        retreived.copy(newPath);
      }

      emit(state.copyWith(
        action: DocumentAction.retreive,
        status: DocumentStatus.success,
      ));
    } catch (err) {
      Utils.log.e('[Error] $err');
      emit(state.copyWith(
          action: DocumentAction.retreive,
          status: DocumentStatus.failure,
          message: err.toString()));
    }
  }

  Future _onDocumentDeleteRequested(
    DocumentDeleteRequested event,
    Emitter<DocumentState> emit,
  ) async {
    emit(state.copyWith(
      action: DocumentAction.delete,
      status: DocumentStatus.loading,
    ));
    var response = await _accountingRepository.deleteDocument(id: event.id);
    if (response.status) {
      emit(state.copyWith(
        action: DocumentAction.delete,
        status: DocumentStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: DocumentAction.delete,
        status: DocumentStatus.failure,
      ));
    }
  }
}
