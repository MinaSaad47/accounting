import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_api/src/models/models.dart';

abstract class AccountingApi {
  Future<ApiResponse<CompanyModel>> createCompany(CompanyModel companyModel);
  Future<ApiResponse<List<CompanyModel>>> searchCompanies(String query);
  Future<ApiResponse<CompanyModel>> updateCompany(CompanyModel companyModel);
  Future<ApiResponse<String>> loginUser(UserModel userModel);
  Future<ApiResponse<List<UserModel>>> getUsers();
  Future<ApiResponse<List<ExpenseModel>>> getExpenses({
    int? userId,
    int? companyId,
  });

  Future<ApiResponse<UserModel>> createUser(UserModel user);
  Future<ApiResponse<ExpenseModel>> createExpense({
    required int companyId,
    required ExpenseModel expenseModel,
  });

  Future<ApiResponse<void>> deleteExpense({
    required int id,
  });

  Future<ApiResponse<UserModel>> getCurrentUser();
  Future<ApiResponse<UserModel>> payUser({
    required int id,
    required double value,
  });

  Future<ApiResponse<void>> deleteCompany({required int id});
  Future<ApiResponse<void>> deleteUser({required int id});
}
