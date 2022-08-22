part of 'employees_cubit.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object> get props => [];
}

class EmployeesInitial extends EmployeesState {}

class EmployeesGetInProgress extends EmployeesState {}

class EmployeesGetSuccess extends EmployeesState {
  final String message;
  final List<UserModel> users;

  const EmployeesGetSuccess(this.message, this.users);

  @override
  List<Object> get props => [message, users];
}

class EmployeesGetFailure extends EmployeesState {
  final String error;

  const EmployeesGetFailure(this.error);

  @override
  List<Object> get props => [error];
}

class EmployeeCreateInProgress extends EmployeesState {}

class EmployeeCreateSuccess extends EmployeesState {
  final UserModel userModel;
  final String message;

  const EmployeeCreateSuccess(this.userModel, this.message);

  @override
  List<Object> get props => [userModel, message];
}

class EmployeeCreateFailure extends EmployeesState {
  final String error;

  const EmployeeCreateFailure(this.error);

  @override
  List<Object> get props => [error];
}
