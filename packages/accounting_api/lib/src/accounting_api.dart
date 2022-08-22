import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_api/src/models/models.dart';

abstract class AccountingApi {
  Future<ApiResponse<CompanyModel>> createCompany(CompanyModel companyModel);
  Future<ApiResponse<List<CompanyModel>>> searchCompanies(String query);
  Future<ApiResponse<CompanyModel>> updateCompany(CompanyModel companyModel);
  Future<ApiResponse<String>> loginUser(UserModel userModel);
  Future<ApiResponse<List<UserModel>>> getUsers();
  Future<ApiResponse<List<MoneyCapitalModel>>> getMoneyCapitals({
    int? userId,
    int? companyId,
  });

  Future<ApiResponse<UserModel>> createUser(UserModel user);
}
