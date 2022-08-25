part of 'money_capital_bloc.dart';

abstract class MoneyCapitalEvent extends Equatable {
  const MoneyCapitalEvent();

  @override
  List<Object> get props => [];
}

class MoneyCapitalCreateRequested extends MoneyCapitalEvent {
  final MoneyCapitalModel moneyCapital;
  final CompanyModel company;

  const MoneyCapitalCreateRequested(this.moneyCapital, this.company);
  @override
  List<Object> get props => [moneyCapital, company];
}

class MoneyCapitalGetRequested extends MoneyCapitalEvent {
  final int? empolyeeId, companyId;

  const MoneyCapitalGetRequested({this.empolyeeId, this.companyId});
}

class MoneyCapitalDeleteRequested extends MoneyCapitalEvent {
  final int id;

  const MoneyCapitalDeleteRequested(this.id);
}
