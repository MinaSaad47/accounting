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

@freezed
class EmployeesState with _$EmployeesState {
  const factory EmployeesState({
    UserModel? selected,
    @Default([]) List<UserModel> list,
    @Default('') String message,
    @Default(EmployeeAction.none) EmployeeAction action,
    @Default(EmployeeStatus.initial) EmployeeStatus status,
  }) = _EmployeesState;
}
