part of 'document_bloc.dart';

enum DocumentStatus {
  initial,
  loading,
  success,
  failure,
}

enum DocumentAction {
  none,
  get,
  create,
  delete,
  retreive,
}

@Freezed(toStringOverride: false)
class DocumentState with _$DocumentState {
  const DocumentState._();
  @override
  String toString() {
    return '($action, $status)';
  }

  const factory DocumentState({
    @Default([]) List<DocumentModel> list,
    @Default(DocumentStatus.initial) DocumentStatus status,
    @Default(DocumentAction.none) DocumentAction action,
    @Default('') String message,
  }) = _DocumentState;
}
