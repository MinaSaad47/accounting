import 'package:accounting_api/accounting_api.dart';
import 'package:accounting_api/src/models/api_response.dart';

abstract class AccountingApi {
  Future<ApiResponse<CompanyModel>> postCompany(CompanyModel companyModel);
  Future<ApiResponse<List<CompanyModel>>> getCompanies(String query);
  Future<ApiResponse<CompanyModel>> putCompany(CompanyModel companyModel);
}
