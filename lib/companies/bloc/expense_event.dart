part of 'expense_bloc.dart';

abstract class MoneyCapitalEvent extends Equatable {
  const MoneyCapitalEvent();

  @override
  List<Object> get props => [];
}

class MoneyCapitalCreateRequested extends MoneyCapitalEvent {
  final ExpenseModel expense;
  final CompanyModel company;

  const MoneyCapitalCreateRequested(this.expense, this.company);
  @override
  List<Object> get props => [expense, company];
}

class ExpenseGetRequested extends MoneyCapitalEvent {
  final int? empolyeeId, companyId;

  const ExpenseGetRequested({this.empolyeeId, this.companyId});
}

class ExpenseDeleteRequested extends MoneyCapitalEvent {
  final int id;

  const ExpenseDeleteRequested(this.id);
}
