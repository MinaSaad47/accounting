import 'package:accounting/utils/utils.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:accounting_api/accounting_api.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employees_cubit.freezed.dart';
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
        list: response.data!,
        message: response.message,
      ));
    } else {
      Utils.log.d(response.message);
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
      Utils.log.e(response.message);
      emit(state.copyWith(
        action: EmployeeAction.create,
        status: EmployeeStatus.failure,
        message: response.message,
      ));
    }
  }

  Future payEmployee({required int id, required double value}) async {
    emit(state.copyWith(
      action: EmployeeAction.pay,
      status: EmployeeStatus.loading,
    ));
    var response = await _accountingRepository.payUser(id: id, value: value);
    if (response.status) {
      Utils.log.d(response.data);
      emit(state.copyWith(
        action: EmployeeAction.pay,
        status: EmployeeStatus.success,
        message: response.message,
        user: response.data,
      ));
    } else {
      Utils.log.e(response.message);
      emit(state.copyWith(
        action: EmployeeAction.pay,
        status: EmployeeStatus.failure,
        message: response.message,
      ));
    }
  }

  Future deleteEmployee({required int id}) async {
    emit(state.copyWith(
      action: EmployeeAction.delete,
      status: EmployeeStatus.loading,
    ));
    var response = await _accountingRepository.deleteUser(id: id);
    if (response.status) {
      emit(state.copyWith(
        action: EmployeeAction.delete,
        status: EmployeeStatus.success,
        message: response.message,
      ));
    } else {
      Utils.log.e(response.message);
      emit(state.copyWith(
        action: EmployeeAction.delete,
        status: EmployeeStatus.failure,
        message: response.message,
      ));
    }
  }
}
