import 'package:accounting_api/accounting_api.dart';
import 'package:dio/dio.dart';

class AccountingDio extends AccountingApi {
  final Dio _dio;

  AccountingDio({required String baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
  @override
  Future<ApiResponse<CompanyModel>> postCompany(
    CompanyModel companyModel,
  ) async {
    var response = await _dio.post(
      'company',
      data: companyModel.toJson(),
    );
    return ApiResponse<CompanyModel>.fromJson(
        response.data, (p0) => CompanyModel.fromJson(p0 as dynamic));
  }

  @override
  Future<ApiResponse<List<CompanyModel>>> getCompanies(String query) async {
    var response = await _dio.get(
      'company',
      queryParameters: {'search': query},
      options: Options(
        validateStatus: (status) => true,
        receiveDataWhenStatusError: true,
      ),
    );
    return ApiResponse<List<CompanyModel>>.fromJson(response.data, (p0) {
      List<CompanyModel> companies = [];
      for (var json in (p0 as List<dynamic>)) {
        companies.add(CompanyModel.fromJson(json as dynamic));
      }
      return companies;
    });
  }

  @override
  Future<ApiResponse<CompanyModel>> putCompany(
      CompanyModel companyModel) async {
    var response = await _dio.put(
      'company',
      data: companyModel.toJson(),
      options: Options(
        validateStatus: (status) => true,
        receiveDataWhenStatusError: true,
      ),
    );
    return ApiResponse<CompanyModel>.fromJson(
        response.data, (p0) => CompanyModel.fromJson(p0 as dynamic));
  }
}
