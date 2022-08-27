part of 'employees_cubit.dart';

enum EmployeeStatus {
  initial,
  loading,
  success,
  failure,
}

enum EmployeeAction {
  none,
  get,
  create,
  pay,
  delete,
}

class EmployeesState extends Equatable {
  final List<UserModel> list;
  final String message;
  final EmployeeAction action;
  final EmployeeStatus status;

  const EmployeesState({
    this.list = const [],
    this.message = '',
    this.action = EmployeeAction.none,
    this.status = EmployeeStatus.initial,
  });

  EmployeesState copyWith({
    EmployeeAction? action,
    EmployeeStatus? status,
    List<UserModel>? list,
    String? message,
  }) =>
      EmployeesState(
        action: action ?? this.action,
        list: list ?? this.list,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  List<Object> get props => [action, message, list, status];
}
