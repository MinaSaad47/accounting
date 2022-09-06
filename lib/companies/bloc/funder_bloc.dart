import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'funder_bloc.freezed.dart';
part 'funder_event.dart';
part 'funder_state.dart';

class FunderBloc extends Bloc<FunderEvent, FunderState> {
  FunderBloc(this._accountingRepository) : super(const FunderState()) {
    on<FunderCreateRequested>(_onFunderCreateRequested);
    on<FunderGetRequested>(_onFunderGetRequested);
    on<FunderDeleteRequested>(_onFunderDeleteRequested);
  }

  final AccountingRepository _accountingRepository;

  Future _onFunderCreateRequested(
    FunderCreateRequested event,
    Emitter<FunderState> emit,
  ) async {
    emit(state.copyWith(
      action: FunderAction.create,
      status: FunderStatus.loading,
    ));
    var response = await _accountingRepository.createFunder(
      companyId: event.company.id!,
      funder: event.funder,
    );
    if (response.status) {
      emit(state.copyWith(
        action: FunderAction.create,
        status: FunderStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: FunderAction.create,
        status: FunderStatus.failure,
        message: response.message,
      ));
    }
  }

  Future _onFunderGetRequested(
    FunderGetRequested event,
    Emitter<FunderState> emit,
  ) async {
    emit(state.copyWith(
      action: FunderAction.get,
      status: FunderStatus.loading,
    ));
    var response = await _accountingRepository.getFunders(
      companyId: event.companyId,
    );
    if (response.status) {
      emit(state.copyWith(
        action: FunderAction.get,
        list: response.data!,
        status: FunderStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: FunderAction.get,
        status: FunderStatus.failure,
      ));
    }
  }

  Future _onFunderDeleteRequested(
    FunderDeleteRequested event,
    Emitter<FunderState> emit,
  ) async {
    emit(state.copyWith(
      action: FunderAction.delete,
      status: FunderStatus.loading,
    ));
    var response = await _accountingRepository.deleteFunder(id: event.id);
    if (response.status) {
      emit(state.copyWith(
        action: FunderAction.delete,
        status: FunderStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: FunderAction.delete,
        status: FunderStatus.failure,
      ));
    }
  }
}
