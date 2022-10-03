part of 'funder_bloc.dart';

abstract class FunderEvent extends Equatable {
  const FunderEvent();

  @override
  List<Object> get props => [];
}

class FunderCreateRequested extends FunderEvent {
  final FunderModel funder;
  final CompanyModel company;

  const FunderCreateRequested(this.funder, this.company);
  @override
  List<Object> get props => [funder, company];
}

class FunderGetRequested extends FunderEvent {
  final String companyId;

  const FunderGetRequested(this.companyId);
}

class FunderDeleteRequested extends FunderEvent {
  final String id;

  const FunderDeleteRequested(this.id);
}
