part of 'expense_bloc.dart';

enum ExpenseStatus {
  initial,
  loading,
  success,
  failure,
}

enum ExpenseAction {
  none,
  get,
  create,
  delete,
}

class ExpenseState extends Equatable {
  final List<ExpenseModel> list;
  final ExpenseStatus status;
  final ExpenseAction action;
  final String message;

  const ExpenseState({
    this.action = ExpenseAction.none,
    this.list = const [],
    this.status = ExpenseStatus.initial,
    this.message = '',
  });

  ExpenseState copyWith({
    List<ExpenseModel>? list,
    ExpenseStatus? status,
    ExpenseAction? action,
    String? message,
  }) =>
      ExpenseState(
        list: list ?? this.list,
        status: status ?? this.status,
        action: action ?? this.action,
        message: message ?? this.message,
      );

  @override
  List<Object> get props => [action, list, status, message];
}
