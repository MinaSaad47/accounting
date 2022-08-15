part of 'companies_cubit.dart';

@immutable
abstract class CompaniesState {}

class CompaniesInitial extends CompaniesState {}

class CompaniesGetInProgress extends CompaniesState {}

class CompaniesGetSuccess extends CompaniesState {
  final String message;
  final List<CompanyModel> companies;

  CompaniesGetSuccess(this.companies, this.message);
}

class CompaniesGetInFailure extends CompaniesState {
  final String error;

  CompaniesGetInFailure(this.error);
}

class CompaniesSaveInProgress extends CompaniesState {}

class CompaniesSaveSuccess extends CompaniesState {
  final String message;
  final CompanyModel companies;

  CompaniesSaveSuccess(this.companies, this.message);
}

class CompaniesSaveInFailure extends CompaniesState {
  final String error;

  CompaniesSaveInFailure(this.error);
}
