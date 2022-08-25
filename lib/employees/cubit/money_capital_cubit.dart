import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'money_capital_state.dart';

class MoneyCapitalCubit extends Cubit<MoneyCapitalState> {
  final AccountingRepository _accountingRepository;
  MoneyCapitalCubit(this._accountingRepository)
      : super(const MoneyCapitalState());

  Future getMoneyCapital({required int employeeId}) async {
    emit(state.copyWith(
      action: MoneyCapitalAction.get,
      status: MoneyCapitalStatus.loading,
    ));
    var resonse = await _accountingRepository.getMoneyCapitals(
      userId: employeeId,
    );
    if (resonse.status) {
      Map<String, List<MoneyCapitalModel>> map = {};
      for (var moneyCapital in resonse.data!) {
        if (!map.containsKey(moneyCapital.companyName)) {
          map.addAll({moneyCapital.companyName!: <MoneyCapitalModel>[]});
        }
        map[moneyCapital.companyName]!.add(moneyCapital);
      }
      List<String> companies = [];
      List<List<MoneyCapitalModel>> moneyCapitals = [];
      map.forEach((key, value) {
        companies.add(key);
        moneyCapitals.add(value);
      });
      emit(state.copyWith(
        action: MoneyCapitalAction.get,
        status: MoneyCapitalStatus.failure,
        companies: companies,
        moneyCapitals: moneyCapitals,
        message: resonse.message,
      ));
    } else {
      emit(state.copyWith(
        action: MoneyCapitalAction.get,
        status: MoneyCapitalStatus.failure,
        message: resonse.message,
      ));
    }
  }
}
