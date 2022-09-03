part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class DocumentCreateRequested extends DocumentEvent {
  final int companyId;
  final File document;

  const DocumentCreateRequested(this.document, this.companyId);
  @override
  List<Object> get props => [document, companyId];
}

class DocumentGetRequested extends DocumentEvent {
  final int companyId;

  const DocumentGetRequested(this.companyId);
}

class DocumentDeleteRequested extends DocumentEvent {
  final int id;

  const DocumentDeleteRequested(this.id);
}
