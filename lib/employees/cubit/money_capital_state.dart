part of 'money_capital_cubit.dart';

enum MoneyCapitalStatus {
  initial,
  loading,
  success,
  failure,
}

enum MoneyCapitalAction {
  none,
  get,
}

class MoneyCapitalState extends Equatable {
  final List<List<MoneyCapitalModel>> moneyCapitals;
  final List<String> companies;
  final MoneyCapitalStatus status;
  final MoneyCapitalAction action;
  final String message;

  const MoneyCapitalState({
    this.action = MoneyCapitalAction.none,
    this.companies = const [],
    this.moneyCapitals = const [],
    this.status = MoneyCapitalStatus.initial,
    this.message = '',
  });

  MoneyCapitalState copyWith({
    List<List<MoneyCapitalModel>>? moneyCapitals,
    List<String>? companies,
    MoneyCapitalStatus? status,
    MoneyCapitalAction? action,
    String? message,
    UserModel? user,
  }) =>
      MoneyCapitalState(
        moneyCapitals: moneyCapitals ?? this.moneyCapitals,
        companies: companies ?? this.companies,
        status: status ?? this.status,
        action: action ?? this.action,
        message: message ?? this.message,
      );

  @override
  List<Object> get props => [action, moneyCapitals, status, message];
}
