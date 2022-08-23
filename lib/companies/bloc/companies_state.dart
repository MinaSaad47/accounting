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

class MoneyCapitalCreateInProgress extends CompaniesState {
  @override
  List<Object?> get props => [];
}

class MoneyCapitalCreateSuccess extends CompaniesState {
  final String message;
  final MoneyCapitalModel moneyCapital;

  MoneyCapitalCreateSuccess(this.moneyCapital, this.message);

  @override
  List<Object?> get props => [message, moneyCapital];
}

class MoneyCapitalCreateFailure extends CompaniesState {
  final String error;

  MoneyCapitalCreateFailure(this.error);

  @override
  List<Object?> get props => [error];
}
