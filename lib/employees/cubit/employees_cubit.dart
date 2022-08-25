import 'package:accounting/common/common.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  final AccountingRepository _accountingRepository;
  EmployeesCubit(this._accountingRepository) : super(const EmployeesState());

  Future getEmployees() async {
    emit(state.copyWith(
      action: EmployeeAction.get,
      status: EmployeeStatus.loading,
    ));
    var response = await _accountingRepository.getUsers();
    if (response.status) {
      emit(state.copyWith(
        action: EmployeeAction.get,
        status: EmployeeStatus.success,
        list: response.data,
        message: response.message,
      ));
    } else {
      log.e(response.message);
      emit(state.copyWith(
        action: EmployeeAction.get,
        status: EmployeeStatus.failure,
        message: response.message,
      ));
    }
  }

  Future createEmployee(UserModel employee) async {
    emit(state.copyWith(
      action: EmployeeAction.create,
      status: EmployeeStatus.loading,
    ));
    var response = await _accountingRepository.createUser(employee);
    if (response.status) {
      emit(state.copyWith(
        action: EmployeeAction.create,
        status: EmployeeStatus.success,
        message: response.message,
      ));
    } else {
      log.e(response.message);
      emit(state.copyWith(
        action: EmployeeAction.create,
        status: EmployeeStatus.failure,
        message: response.message,
      ));
    }
  }
}
