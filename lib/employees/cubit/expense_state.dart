part of 'expense_cubit.dart';

enum ExpenseStatus {
  initial,
  loading,
  success,
  failure,
}

enum ExpenseAction {
  none,
  get,
}

class ExpenseState extends Equatable {
  final List<List<ExpenseModel>> expense;
  final List<String> companies;
  final ExpenseStatus status;
  final ExpenseAction action;
  final String message;

  const ExpenseState({
    this.action = ExpenseAction.none,
    this.companies = const [],
    this.expense = const [],
    this.status = ExpenseStatus.initial,
    this.message = '',
  });

  ExpenseState copyWith({
    List<List<ExpenseModel>>? expense,
    List<String>? companies,
    ExpenseStatus? status,
    ExpenseAction? action,
    String? message,
    UserModel? user,
  }) =>
      ExpenseState(
        expense: expense ?? this.expense,
        companies: companies ?? this.companies,
        status: status ?? this.status,
        action: action ?? this.action,
        message: message ?? this.message,
      );

  @override
  List<Object> get props => [action, expense, status, message];
}
