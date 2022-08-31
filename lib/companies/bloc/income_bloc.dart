import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_bloc.freezed.dart';
part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc(this._accountingRepository) : super(const IncomeState()) {
    on<IncomeCreateRequested>(_onIncomeCreateRequested);
    on<IncomeGetRequested>(_onIncomeGetRequested);
    on<IncomeDeleteRequested>(_onIncomeDeleteRequested);
  }

  final AccountingRepository _accountingRepository;

  Future _onIncomeCreateRequested(
    IncomeCreateRequested event,
    Emitter<IncomeState> emit,
  ) async {
    emit(state.copyWith(
      action: IncomeAction.create,
      status: IncomeStatus.loading,
    ));
    var response = await _accountingRepository.createIncome(
      companyId: event.company.id!,
      incomeModel: event.income,
    );
    if (response.status) {
      emit(state.copyWith(
        action: IncomeAction.create,
        status: IncomeStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: IncomeAction.create,
        status: IncomeStatus.failure,
        message: response.message,
      ));
    }
  }

  Future _onIncomeGetRequested(
    IncomeGetRequested event,
    Emitter<IncomeState> emit,
  ) async {
    emit(state.copyWith(
      action: IncomeAction.get,
      status: IncomeStatus.loading,
    ));
    var response = await _accountingRepository.getIncomes(
      adminId: event.empolyeeId,
      companyId: event.companyId,
    );
    if (response.status) {
      emit(state.copyWith(
        action: IncomeAction.get,
        list: response.data!,
        status: IncomeStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: IncomeAction.get,
        status: IncomeStatus.failure,
      ));
    }
  }

  Future _onIncomeDeleteRequested(
    IncomeDeleteRequested event,
    Emitter<IncomeState> emit,
  ) async {
    emit(state.copyWith(
      action: IncomeAction.delete,
      status: IncomeStatus.loading,
    ));
    var response = await _accountingRepository.deleteIncome(id: event.id);
    if (response.status) {
      emit(state.copyWith(
        action: IncomeAction.delete,
        status: IncomeStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: IncomeAction.delete,
        status: IncomeStatus.failure,
      ));
    }
  }
}
