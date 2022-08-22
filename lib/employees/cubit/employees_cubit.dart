import 'package:accounting/common/common.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  final AccountingRepository _accountingRepository;
  EmployeesCubit(this._accountingRepository) : super(EmployeesInitial());

  Future getEmployees() async {
    emit(EmployeesGetInProgress());
    var response = await _accountingRepository.getUsers();
    if (response.status) {
      emit(EmployeesGetSuccess(response.message, response.data!));
    } else {
      log.e(response.message);
      emit(EmployeesGetFailure(response.message));
    }
  }

  Future createEmployee(UserModel employee) async {
    var response = await _accountingRepository.createUser(employee);
    if (response.status) {
      emit(EmployeeCreateSuccess(response.data!, response.message));
    } else {
      log.e(response.message);
      emit(EmployeeCreateFailure(response.message));
    }
  }
}
