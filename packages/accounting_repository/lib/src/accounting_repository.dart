import 'dart:io';

import 'package:accounting_api/accounting_api.dart';

class AccountingRepository {
  final AccountingApi _accountingApi;

  AccountingRepository(this._accountingApi);

  Future<ApiResponse<CompanyModel>> createCompany(
      CompanyModel companyModel) async {
    try {
      return await _accountingApi.createCompany(companyModel);
    } on UserUnauthorizedError catch (_) {}
    throw Error();
  }

  Future<ApiResponse<List<CompanyModel>>> getCompanies(String query) async =>
      await _accountingApi.searchCompanies(query);
  Future<ApiResponse<CompanyModel>> saveCompany(
      CompanyModel companyModel) async {
    try {
      return await _accountingApi.updateCompany(companyModel);
    } on UserUnauthorizedError catch (_) {}
    throw Error();
  }

  Future<ApiResponse<String>> loginUser(UserModel userModel) async {
    var response = await _accountingApi.loginUser(userModel);
    return response;
  }

  Future<ApiResponse<List<UserModel>>> getUsers() async =>
      await _accountingApi.getUsers();

  Future<ApiResponse<UserModel>> createUser(UserModel user) async =>
      await _accountingApi.createUser(user);

  Future<ApiResponse<List<ExpenseModel>>> getExpenses({
    int? userId,
    int? companyId,
  }) async =>
      await _accountingApi.getExpenses(
        userId: userId,
        companyId: companyId,
      );

  Future<ApiResponse<ExpenseModel>> createExpense({
    required int companyId,
    required ExpenseModel expenseModel,
  }) async =>
      await _accountingApi.createExpense(
        companyId: companyId,
        expenseModel: expenseModel,
      );

  Future<ApiResponse<void>> deleteExpense({required int id}) async =>
      await _accountingApi.deleteExpense(id: id);

  Future<ApiResponse<List<IncomeModel>>> getIncomes({
    int? adminId,
    int? companyId,
  }) async =>
      await _accountingApi.getIncomes(
        adminId: adminId,
        companyId: companyId,
      );

  Future<ApiResponse<IncomeModel>> createIncome({
    required int companyId,
    required IncomeModel incomeModel,
  }) async =>
      await _accountingApi.createIncome(
        companyId: companyId,
        incomeModel: incomeModel,
      );

  Future<ApiResponse<void>> deleteIncome({required int id}) async =>
      await _accountingApi.deleteIncome(id: id);

  Future<ApiResponse<UserModel>> getCurrentUser() async =>
      await _accountingApi.getCurrentUser();

  Future<ApiResponse<UserModel>> payUser({
    required int id,
    required double value,
  }) async =>
      _accountingApi.payUser(id: id, value: value);

  Future<ApiResponse<void>> deleteCompany({required int id}) async =>
      await _accountingApi.deleteCompany(id: id);

  Future<ApiResponse<void>> deleteUser({required int id}) async =>
      await _accountingApi.deleteUser(id: id);

  Future<ApiResponse<DocumentModel>> createDocument({
    required int companyId,
    required File document,
  }) async =>
      _accountingApi.createDocument(companyId: companyId, document: document);

  Future<ApiResponse<List<DocumentModel>>> getDocuments({
    required int companyId,
  }) async =>
      _accountingApi.getDocuments(companyId: companyId);

  Future<File> retreiveDocument({required String path}) async =>
      _accountingApi.retreiveDocument(path: path);
}
