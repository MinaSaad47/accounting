part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class DocumentCreateRequested extends DocumentEvent {
  final int companyId;
  final void Function(double) onProgress;

  const DocumentCreateRequested(this.companyId, this.onProgress);
  @override
  List<Object> get props => [companyId];
}

class DocumentGetRequested extends DocumentEvent {
  final int companyId;

  const DocumentGetRequested(this.companyId);
}

class DocumentDeleteRequested extends DocumentEvent {
  final String path;

  const DocumentDeleteRequested(this.path);
}

class DocumentRetreiveRequested extends DocumentEvent {
  final String path;
  final void Function(double) onProgress;

  const DocumentRetreiveRequested(this.path, this.onProgress);
}
