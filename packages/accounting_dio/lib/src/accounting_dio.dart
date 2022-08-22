import 'package:accounting_api/accounting_api.dart';
import 'package:dio/dio.dart';

class AccountingDio extends AccountingApi {
  final Dio _dio;

  AccountingDio({required String baseUrl, String? token})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
            headers: {
              if (token != null) 'authorization': token,
            },
          ),
        );
  @override
  Future<ApiResponse<CompanyModel>> createCompany(
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
  Future<ApiResponse<List<CompanyModel>>> searchCompanies(String query) async {
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
  Future<ApiResponse<CompanyModel>> updateCompany(
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

  @override
  Future<ApiResponse<String>> loginUser(UserModel userModel) async {
    var response = await _dio.post(
      'users/login',
      data: userModel.toJson(),
    );
    var apiResponse =
        ApiResponse<String>.fromJson(response.data, (p0) => p0 as String);
    if (apiResponse.status) {
      _dio.options.headers.addAll({'authorization': apiResponse.data});
    }
    return apiResponse;
  }

  @override
  Future<ApiResponse<List<UserModel>>> getUsers() async {
    var response = await _dio.get('users');

    return ApiResponse<List<UserModel>>.fromJson(response.data, (p0) {
      List<UserModel> users = [];
      for (var json in (p0 as List<dynamic>)) {
        users.add(UserModel.fromJson(json as dynamic));
      }
      return users;
    });
  }

  @override
  Future<ApiResponse<List<MoneyCapitalModel>>> getMoneyCapitals({
    int? userId,
    int? companyId,
  }) async {
    var response = await _dio.get('money_capitals', queryParameters: {
      'user.id': userId,
      'company.id': companyId,
    });

    return ApiResponse<List<MoneyCapitalModel>>.fromJson(response.data, (p0) {
      List<MoneyCapitalModel> moneyCapitals = [];
      for (var json in (p0 as List<dynamic>)) {
        moneyCapitals.add(MoneyCapitalModel.fromJson(json));
      }
      return moneyCapitals;
    });
  }

  @override
  Future<ApiResponse<UserModel>> createUser(UserModel user) async {
    var response = await _dio.post('users', data: user.toJson());
    return ApiResponse<UserModel>.fromJson(
        response.data, (p0) => UserModel.fromJson(p0 as dynamic));
  }
}
