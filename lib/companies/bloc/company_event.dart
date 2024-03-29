part of 'company_bloc.dart';

abstract class CompanyEvent extends Equatable {}

class CompanyCreateRequested extends CompanyEvent {
  final CompanyModel company;

  CompanyCreateRequested(this.company);

  @override
  List<Object?> get props => [company];
}

class CompanySearchRequested extends CompanyEvent {
  final String query;

  CompanySearchRequested(this.query);

  @override
  List<Object?> get props => [query];
}

class CompanyEditRequested extends CompanyEvent {
  final CompanyModel company;

  CompanyEditRequested(this.company);

  @override
  List<Object?> get props => [company];
}

class CompanyDeleteRequested extends CompanyEvent {
  final String id;

  CompanyDeleteRequested(this.id);

  @override
  List<Object?> get props => [id];
}
