import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class MoneyCapitalBloc extends Bloc<MoneyCapitalEvent, ExpenseState> {
  MoneyCapitalBloc(this._accountingRepository) : super(const ExpenseState()) {
    on<MoneyCapitalCreateRequested>(_onExpenseCreateRequested);
    on<ExpenseGetRequested>(_onExpenseGetRequested);
    on<ExpenseDeleteRequested>(_onExpenseDeleteRequested);
  }

  final AccountingRepository _accountingRepository;

  Future _onExpenseCreateRequested(
    MoneyCapitalCreateRequested event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(state.copyWith(
      action: ExpenseAction.create,
      status: ExpenseStatus.loading,
    ));
    var response = await _accountingRepository.createExpense(
      companyId: event.company.id!,
      expenseModel: event.expense,
    );
    if (response.status) {
      emit(state.copyWith(
        action: ExpenseAction.create,
        status: ExpenseStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: ExpenseAction.create,
        status: ExpenseStatus.failure,
        message: response.message,
      ));
    }
  }

  Future _onExpenseGetRequested(
    ExpenseGetRequested event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(state.copyWith(
      action: ExpenseAction.get,
      status: ExpenseStatus.loading,
    ));
    var response = await _accountingRepository.getExpenses(
      userId: event.empolyeeId,
      companyId: event.companyId,
    );
    if (response.status) {
      emit(state.copyWith(
        action: ExpenseAction.get,
        list: response.data,
        status: ExpenseStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: ExpenseAction.get,
        status: ExpenseStatus.failure,
      ));
    }
  }

  Future _onExpenseDeleteRequested(
    ExpenseDeleteRequested event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(state.copyWith(
      action: ExpenseAction.delete,
      status: ExpenseStatus.loading,
    ));
    var response = await _accountingRepository.deleteExpense(id: event.id);
    if (response.status) {
      emit(state.copyWith(
        action: ExpenseAction.delete,
        status: ExpenseStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: ExpenseAction.delete,
        status: ExpenseStatus.failure,
      ));
    }
  }
}