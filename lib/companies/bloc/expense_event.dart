part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class ExpenseCreateRequested extends ExpenseEvent {
  final ExpenseModel expense;
  final CompanyModel company;

  const ExpenseCreateRequested(this.expense, this.company);
  @override
  List<Object> get props => [expense, company];
}

class ExpenseGetRequested extends ExpenseEvent {
  final int? empolyeeId, companyId;

  const ExpenseGetRequested({this.empolyeeId, this.companyId});
}

class ExpenseDeleteRequested extends ExpenseEvent {
  final int id;

  const ExpenseDeleteRequested(this.id);
}
