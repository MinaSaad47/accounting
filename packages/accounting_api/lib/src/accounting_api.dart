import 'dart:io';

import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_api/src/models/models.dart';

abstract class AccountingApi {
  /* Companies */
  Future<ApiResponse<CompanyModel>> createCompany(CompanyModel companyModel);
  Future<ApiResponse<List<CompanyModel>>> searchCompanies(String query);
  Future<ApiResponse<CompanyModel>> updateCompany({
    required String id,
    required CompanyModel company,
  });
  Future<ApiResponse<void>> deleteCompany({required String id});

  /* Expenses */
  Future<ApiResponse<List<ExpenseModel>>> getExpenses({
    String? userId,
    String? companyId,
  });
  Future<ApiResponse<ExpenseModel>> createExpense({
    required String companyId,
    required ExpenseModel expenseModel,
  });
  Future<ApiResponse<void>> deleteExpense({required String id});

  /* Incomes */
  Future<ApiResponse<List<IncomeModel>>> getIncomes({
    String? adminId,
    String? companyId,
  });
  Future<ApiResponse<IncomeModel>> createIncome({
    required String companyId,
    required IncomeModel incomeModel,
  });
  Future<ApiResponse<void>> deleteIncome({required String id});

  /* Users */
  Future<ApiResponse<UserModel>> getCurrentUser();
  Future<ApiResponse<UserModel>> payUser({
    required String id,
    required double value,
  });
  Future<ApiResponse<void>> deleteUser({required String id});
  Future<ApiResponse<String>> loginUser(UserModel userModel);
  Future<ApiResponse<List<UserModel>>> getUsers();
  Future<ApiResponse<UserModel>> createUser(UserModel user);

  /* Documents  */
  Future<ApiResponse<List<DocumentModel>>> getDocuments({
    required String companyId,
  });
  Future<ApiResponse<DocumentModel>> createDocument({
    required String companyId,
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
    required String companyId,
  });

  Future<ApiResponse<FunderModel>> createFunder({
    required String companyId,
    required FunderModel funder,
  });

  Future<ApiResponse<String>> deleteFunder({required String id});
}
