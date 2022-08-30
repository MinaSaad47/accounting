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
}
