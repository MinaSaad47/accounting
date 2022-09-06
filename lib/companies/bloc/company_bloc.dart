import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

part 'company_bloc.freezed.dart';
part 'company_event.dart';
part 'company_state.dart';

const _duration = Duration(milliseconds: 1000);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class CompaniesBloc extends Bloc<CompanyEvent, CompanyState> {
  final AccountingRepository _accountingRepository;
  CompaniesBloc(this._accountingRepository) : super(const CompanyState()) {
    on<CompanyEditRequested>(_onEditRequested);
    on<CompanySearchRequested>(
      _onSearchRequested,
      transformer: debounce(_duration),
    );
    on<CompanyCreateRequested>(_onCreateRequested);
    on<CompanyDeleteRequested>(_onDeleteRequested);
  }

  Future _onCreateRequested(
    CompanyCreateRequested event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(
      action: CompanyAction.save,
      status: CompanyStatus.loading,
    ));
    var response = await _accountingRepository.createCompany(event.company);
    if (response.status) {
      emit(state.copyWith(
        action: CompanyAction.save,
        status: CompanyStatus.success,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: CompanyAction.save,
        status: CompanyStatus.failure,
        message: response.message,
      ));
    }
  }

  Future _onEditRequested(
    CompanyEditRequested event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(
      action: CompanyAction.save,
      status: CompanyStatus.loading,
    ));
    var response = await _accountingRepository.saveCompany(event.company);
    if (response.status) {
      emit(state.copyWith(
        action: CompanyAction.save,
        status: CompanyStatus.success,
        list: [],
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: CompanyAction.save,
        status: CompanyStatus.failure,
        message: response.message,
      ));
    }
  }

  Future _onSearchRequested(
    CompanySearchRequested event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(
      action: CompanyAction.get,
      status: CompanyStatus.loading,
    ));
    var response = await _accountingRepository.getCompanies(event.query);
    if (response.status) {
      emit(state.copyWith(
        action: CompanyAction.get,
        status: CompanyStatus.success,
        list: response.data!,
        message: response.message,
      ));
    } else {
      emit(state.copyWith(
        action: CompanyAction.get,
        status: CompanyStatus.failure,
        message: response.message,
      ));
    }
  }

  Future _onDeleteRequested(
    CompanyDeleteRequested event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(
      action: CompanyAction.delete,
      status: CompanyStatus.loading,
    ));
    var response = await _accountingRepository.deleteCompany(id: event.id);
    if (response.status) {
      emit(state.copyWith(
        action: CompanyAction.delete,
        message: response.message,
        status: CompanyStatus.success,
        list: [],
      ));
    } else {
      emit(state.copyWith(
        action: CompanyAction.delete,
        message: response.message,
        status: CompanyStatus.failure,
      ));
    }
  }
}
