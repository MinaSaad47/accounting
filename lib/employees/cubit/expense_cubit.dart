import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expense_state.dart';

class MoneyCapitalCubit extends Cubit<ExpenseState> {
  final AccountingRepository _accountingRepository;
  MoneyCapitalCubit(this._accountingRepository) : super(const ExpenseState());

  Future getMoneyCapital({required String employeeId}) async {
    emit(state.copyWith(
      action: ExpenseAction.get,
      status: ExpenseStatus.loading,
    ));
    var resonse = await _accountingRepository.getExpenses(
      userId: employeeId,
    );
    if (resonse.status) {
      Map<String, List<ExpenseModel>> map = {};
      for (var expense in resonse.data!) {
        if (!map.containsKey(expense.companyName)) {
          map.addAll({expense.companyName!: <ExpenseModel>[]});
        }
        map[expense.companyName]!.add(expense);
      }
      List<String> companies = [];
      List<List<ExpenseModel>> expense = [];
      map.forEach((key, value) {
        companies.add(key);
        expense.add(value);
      });
      emit(state.copyWith(
        action: ExpenseAction.get,
        status: ExpenseStatus.failure,
        companies: companies,
        expense: expense,
        message: resonse.message,
      ));
    } else {
      emit(state.copyWith(
        action: ExpenseAction.get,
        status: ExpenseStatus.failure,
        message: resonse.message,
      ));
    }
  }
}
