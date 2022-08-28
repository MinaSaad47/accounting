import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stream_transform/stream_transform.dart';

part 'companies_event.dart';
part 'companies_state.dart';

const _duration = Duration(milliseconds: 1000);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  final AccountingRepository _accountingRepository;
  CompaniesBloc(this._accountingRepository) : super(CompaniesInitial()) {
    on<CompaniesEditRequested>(_onEditRequested);
    on<CompaniesSearchRequested>(
      _onSearchRequested,
      transformer: debounce(_duration),
    );
    on<CompaniesCreateRequested>(_onCreateRequested);
    on<CompaniesDeleteRequested>(_onDeleteRequested);
  }

  Future _onCreateRequested(
    CompaniesCreateRequested event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(CompaniesSaveInProgress());
    var response = await _accountingRepository.createCompany(event.company);
    if (response.status) {
      emit(CompaniesSaveSuccess(response.data!, response.message));
    } else {
      emit(CompaniesSaveFailure(response.message));
    }
  }

  Future _onEditRequested(
    CompaniesEditRequested event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(CompaniesSaveInProgress());
    var response = await _accountingRepository.saveCompany(event.company);
    if (response.status) {
      emit(CompaniesSaveSuccess(response.data!, response.message));
    } else {
      emit(CompaniesSaveFailure(response.message));
    }
  }

  Future _onSearchRequested(
    CompaniesSearchRequested event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(CompaniesGetInProgress());
    var response = await _accountingRepository.getCompanies(event.query);
    if (response.status) {
      emit(CompaniesGetSuccess(response.data!, response.message));
    } else {
      emit(CompaniesGetInFailure(response.message));
    }
  }

  Future _onDeleteRequested(
    CompaniesDeleteRequested event,
    Emitter<CompaniesState> emit,
  ) async {
    emit(CompaniesDeleteInProgress());
    var response = await _accountingRepository.deleteCompany(id: event.id);
    if (response.status) {
      emit(CompaniesDeleteSuccess(response.message));
    } else {
      emit(CompaniesDeleteFailure(response.message));
    }
  }
}