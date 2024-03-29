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

@Freezed(toStringOverride: false)
class ExpenseState with _$ExpenseState {
  const ExpenseState._();
  @override
  String toString() {
    return '($action, $status)';
  }

  double get total => list.map((e) => e.value).fold(0.0, (p, c) => p + c);

  const factory ExpenseState({
    @Default([]) List<ExpenseModel> list,
    @Default(ExpenseStatus.initial) ExpenseStatus status,
    @Default(ExpenseAction.none) ExpenseAction action,
    @Default('') String message,
  }) = _ExpenseState;
}
