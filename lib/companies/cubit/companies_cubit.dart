import 'package:accounting_repository/accounting_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  final AccountingRepository _accountingRepository;
  CompaniesCubit(this._accountingRepository) : super(CompaniesInitial());

  Future saveCompany(CompanyModel companyModel) async {
    emit(CompaniesSaveInProgress());
    var response = await _accountingRepository.saveCompany(companyModel);
    if (response.status) {
      emit(CompaniesSaveSuccess(response.data!, response.message));
    } else {
      emit(CompaniesSaveInFailure(response.message));
    }
  }

  Future getCompanies(String query) async {
    emit(CompaniesGetInProgress());
    var response = await _accountingRepository.getCompanies(query);
    if (response.status) {
      emit(CompaniesGetSuccess(response.data!, response.message));
    } else {
      emit(CompaniesGetInFailure(response.message));
    }
  }
}
