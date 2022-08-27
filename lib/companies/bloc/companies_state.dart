part of 'companies_bloc.dart';

@immutable
abstract class CompaniesState extends Equatable {}

class CompaniesInitial extends CompaniesState {
  @override
  List<Object?> get props => [];
}

class CompaniesGetInProgress extends CompaniesState {
  @override
  List<Object?> get props => [];
}

class CompaniesGetSuccess extends CompaniesState {
  final String message;
  final List<CompanyModel> companies;

  CompaniesGetSuccess(this.companies, this.message);

  @override
  List<Object?> get props => [message, companies];
}

class CompaniesGetInFailure extends CompaniesState {
  final String error;

  CompaniesGetInFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CompaniesSaveInProgress extends CompaniesState {
  @override
  List<Object?> get props => [];
}

class CompaniesSaveSuccess extends CompaniesState {
  final String message;
  final CompanyModel companies;

  CompaniesSaveSuccess(this.companies, this.message);

  @override
  List<Object?> get props => [message, companies];
}

class CompaniesSaveFailure extends CompaniesState {
  final String error;

  CompaniesSaveFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CompaniesDeleteInProgress extends CompaniesState {
  @override
  List<Object?> get props => [];
}

class CompaniesDeleteSuccess extends CompaniesState {
  final String message;

  CompaniesDeleteSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class CompaniesDeleteFailure extends CompaniesState {
  final String error;

  CompaniesDeleteFailure(this.error);
  @override
  List<Object?> get props => [error];
}
