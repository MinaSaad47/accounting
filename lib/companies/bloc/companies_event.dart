part of "companies_bloc.dart";

abstract class CompaniesEvent extends Equatable {}

class CompaniesCreateRequested extends CompaniesEvent {
  final CompanyModel company;

  CompaniesCreateRequested(this.company);

  @override
  List<Object?> get props => [company];
}

class CompaniesSearchRequested extends CompaniesEvent {
  final String query;

  CompaniesSearchRequested(this.query);

  @override
  List<Object?> get props => [query];
}

class CompaniesEditRequested extends CompaniesEvent {
  final CompanyModel company;

  CompaniesEditRequested(this.company);

  @override
  List<Object?> get props => [company];
}

class MoneyCapitalCreateRequested extends CompaniesEvent {
  final MoneyCapitalModel moneyCapital;
  final CompanyModel company;

  MoneyCapitalCreateRequested(this.moneyCapital, this.company);
  @override
  List<Object?> get props => [moneyCapital, company];
}
