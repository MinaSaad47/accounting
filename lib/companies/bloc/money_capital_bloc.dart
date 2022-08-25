import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'money_capital_event.dart';
part 'money_capital_state.dart';

class MoneyCapitalBloc extends Bloc<MoneyCapitalEvent, MoneyCapitalState> {
  MoneyCapitalBloc(this._accountingRepository)
      : super(const MoneyCapitalState()) {
    on<MoneyCapitalCreateRequested>(_onMoneyCapitalCreateRequested);
    on<MoneyCapitalGetRequested>(_onMoneyCapitalGetRequested);
    on<MoneyCapitalDeleteRequested>(_onMoneyCapitalDeleteRequested);
  }

  final AccountingRepository _accountingRepository;

  Future _onMoneyCapitalCreateRequested(
    MoneyCapitalCreateRequested event,
    Emitter<MoneyCapitalState> emit,
  ) async {
    emit(state.copyWith(
      action: MoneyCapitalAction.create,
      status: MoneyCapitalStatus.loading,
    ));
    var response = await _accountingRepository.createMoneyCapital(
      companyId: event.company.id!,
      moneyCapitalModel: event.moneyCapital,
    );
    if (response.status) {
      emit(state.copyWith(
        action: MoneyCapitalAction.create,
        status: MoneyCapitalStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: MoneyCapitalAction.create,
        status: MoneyCapitalStatus.failure,
        message: response.message,
      ));
    }
  }

  Future _onMoneyCapitalGetRequested(
    MoneyCapitalGetRequested event,
    Emitter<MoneyCapitalState> emit,
  ) async {
    emit(state.copyWith(
      action: MoneyCapitalAction.get,
      status: MoneyCapitalStatus.loading,
    ));
    var response = await _accountingRepository.getMoneyCapitals(
      userId: event.empolyeeId,
      companyId: event.companyId,
    );
    if (response.status) {
      emit(state.copyWith(
        action: MoneyCapitalAction.get,
        list: response.data,
        status: MoneyCapitalStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: MoneyCapitalAction.get,
        status: MoneyCapitalStatus.failure,
      ));
    }
  }

  Future _onMoneyCapitalDeleteRequested(
    MoneyCapitalDeleteRequested event,
    Emitter<MoneyCapitalState> emit,
  ) async {
    emit(state.copyWith(
      action: MoneyCapitalAction.delete,
      status: MoneyCapitalStatus.loading,
    ));
    var response = await _accountingRepository.deleteMoneyCapital(id: event.id);
    if (response.status) {
      emit(state.copyWith(
        action: MoneyCapitalAction.delete,
        status: MoneyCapitalStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: MoneyCapitalAction.delete,
        status: MoneyCapitalStatus.failure,
      ));
    }
  }
}
