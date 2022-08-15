import 'package:accounting_api/accounting_api.dart';

class AccountingRepository {
  final AccountingApi accountingApi;

  AccountingRepository(this.accountingApi);

  Future<ApiResponse<CompanyModel>> createCompany(
          CompanyModel companyModel) async =>
      await accountingApi.postCompany(companyModel);
  Future<ApiResponse<List<CompanyModel>>> getCompanies(String query) async =>
      await accountingApi.getCompanies(query);
  Future<ApiResponse<CompanyModel>> saveCompany(
          CompanyModel companyModel) async =>
      await accountingApi.putCompany(companyModel);
}
