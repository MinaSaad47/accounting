import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_api/src/models/models.dart';

abstract class AccountingApi {
  /* Companies */
  Future<ApiResponse<CompanyModel>> createCompany(CompanyModel companyModel);
  Future<ApiResponse<List<CompanyModel>>> searchCompanies(String query);
  Future<ApiResponse<CompanyModel>> updateCompany(CompanyModel companyModel);
  Future<ApiResponse<void>> deleteCompany({required int id});

  /* Expenses */
  Future<ApiResponse<List<ExpenseModel>>> getExpenses({
    int? userId,
    int? companyId,
  });
  Future<ApiResponse<ExpenseModel>> createExpense({
    required int companyId,
    required ExpenseModel expenseModel,
  });
  Future<ApiResponse<void>> deleteExpense({required int id});

  /* Incomes */
  Future<ApiResponse<List<IncomeModel>>> getIncomes({
    int? adminId,
    int? companyId,
  });
  Future<ApiResponse<IncomeModel>> createIncome({
    required int companyId,
    required IncomeModel incomeModel,
  });
  Future<ApiResponse<void>> deleteIncome({required int id});

  /* Users */
  Future<ApiResponse<UserModel>> getCurrentUser();
  Future<ApiResponse<UserModel>> payUser({
    required int id,
    required double value,
  });
  Future<ApiResponse<void>> deleteUser({required int id});
  Future<ApiResponse<String>> loginUser(UserModel userModel);
  Future<ApiResponse<List<UserModel>>> getUsers();
  Future<ApiResponse<UserModel>> createUser(UserModel user);
}
