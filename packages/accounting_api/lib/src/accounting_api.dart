import 'dart:io';

import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_api/src/models/models.dart';

abstract class AccountingApi {
  /* Companies */
  Future<ApiResponse<CompanyModel>> createCompany(CompanyModel companyModel);
  Future<ApiResponse<List<CompanyModel>>> searchCompanies(String query);
  Future<ApiResponse<CompanyModel>> updateCompany({
    required int id,
    required CompanyModel company,
  });
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

  /* Documents  */
  Future<ApiResponse<List<DocumentModel>>> getDocuments({
    required int companyId,
  });
  Future<ApiResponse<DocumentModel>> createDocument({
    required int companyId,
    required File document,
    required void Function(double) onProgress,
  });
  Future<File> retreiveDocument({
    required String path,
    required void Function(double) onProgress,
  });
  Future<ApiResponse<String>> deleteDocument({required String path});

  /* Funders  */
  Future<ApiResponse<List<FunderModel>>> getFunders({
    required int companyId,
  });

  Future<ApiResponse<FunderModel>> createFunder({
    required int companyId,
    required FunderModel funder,
  });

  Future<ApiResponse<String>> deleteFunder({required int id});
}
