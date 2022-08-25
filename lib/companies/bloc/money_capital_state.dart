part of 'money_capital_bloc.dart';

enum MoneyCapitalStatus {
  initial,
  loading,
  success,
  failure,
}

enum MoneyCapitalAction {
  none,
  get,
  create,
  delete,
}

class MoneyCapitalState extends Equatable {
  final List<MoneyCapitalModel> list;
  final MoneyCapitalStatus status;
  final MoneyCapitalAction action;
  final String message;

  const MoneyCapitalState({
    this.action = MoneyCapitalAction.none,
    this.list = const [],
    this.status = MoneyCapitalStatus.initial,
    this.message = '',
  });

  MoneyCapitalState copyWith({
    List<MoneyCapitalModel>? list,
    MoneyCapitalStatus? status,
    MoneyCapitalAction? action,
    String? message,
  }) =>
      MoneyCapitalState(
        list: list ?? this.list,
        status: status ?? this.status,
        action: action ?? this.action,
        message: message ?? this.message,
      );

  @override
  List<Object> get props => [action, list, status, message];
}