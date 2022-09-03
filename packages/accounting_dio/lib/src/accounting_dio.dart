import 'dart:io';

import 'package:accounting_api/accounting_api.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
  Future<ApiResponse<List<ExpenseModel>>> getExpenses({
    int? userId,
    int? companyId,
  }) async {
    var response = await _dio.get('expenses', queryParameters: {
      'user.id': userId,
      'company.id': companyId,
    });

    return ApiResponse<List<ExpenseModel>>.fromJson(response.data, (p0) {
      List<ExpenseModel> expenses = [];
      for (var json in (p0 as List<dynamic>)) {
        expenses.add(ExpenseModel.fromJson(json));
      }
      return expenses;
    });
  }

  @override
  Future<ApiResponse<ExpenseModel>> createExpense({
    required int companyId,
    required ExpenseModel expenseModel,
  }) async {
    var response = await _dio.post(
      '/company/$companyId/expenses',
      data: expenseModel.toJson(),
    );
    return ApiResponse<ExpenseModel>.fromJson(
        response.data, (p0) => ExpenseModel.fromJson(p0 as dynamic));
  }

  @override
  Future<ApiResponse<void>> deleteExpense({required int id}) async {
    var response = await _dio.delete('expenses/$id');
    return ApiResponse<void>.fromJson(response.data, (p0) => dynamic);
  }

  @override
  Future<ApiResponse<UserModel>> createUser(UserModel user) async {
    var response = await _dio.post('users', data: user.toJson());
    return ApiResponse<UserModel>.fromJson(
        response.data, (p0) => UserModel.fromJson(p0 as dynamic));
  }

  @override
  Future<ApiResponse<UserModel>> getCurrentUser() async {
    var response = await _dio.get('/users/current');
    return ApiResponse<UserModel>.fromJson(
        response.data, (p0) => UserModel.fromJson(p0 as dynamic));
  }

  @override
  Future<ApiResponse<UserModel>> payUser({
    required int id,
    required double value,
  }) async {
    var response = await _dio.patch('users/$id', data: {'value': value});
    return ApiResponse<UserModel>.fromJson(
        response.data, (p0) => UserModel.fromJson(p0 as dynamic));
  }

  @override
  Future<ApiResponse<void>> deleteCompany({required int id}) async {
    var response = await _dio.delete('company/$id');
    return ApiResponse<void>.fromJson(response.data, (p0) => dynamic);
  }

  @override
  Future<ApiResponse<void>> deleteUser({required int id}) async {
    var response = await _dio.delete('users/$id');
    return ApiResponse<void>.fromJson(response.data, (p0) => dynamic);
  }

  @override
  Future<ApiResponse<List<IncomeModel>>> getIncomes({
    int? adminId,
    int? companyId,
  }) async {
    var response = await _dio.get('incomes', queryParameters: {
      'admin.id': adminId,
      'company.id': companyId,
    });

    return ApiResponse<List<IncomeModel>>.fromJson(response.data, (p0) {
      List<IncomeModel> expenses = [];
      for (var json in (p0 as List<dynamic>)) {
        expenses.add(IncomeModel.fromJson(json));
      }
      return expenses;
    });
  }

  @override
  Future<ApiResponse<IncomeModel>> createIncome({
    required int companyId,
    required IncomeModel incomeModel,
  }) async {
    var response = await _dio.post(
      '/company/$companyId/incomes',
      data: incomeModel.toJson(),
    );
    return ApiResponse<IncomeModel>.fromJson(
        response.data, (p0) => IncomeModel.fromJson(p0 as dynamic));
  }

  @override
  Future<ApiResponse<void>> deleteIncome({required int id}) async {
    var response = await _dio.delete('incomes/$id');
    return ApiResponse<void>.fromJson(response.data, (p0) => dynamic);
  }

  @override
  Future<ApiResponse<DocumentModel>> createDocument({
    required int companyId,
    required File document,
  }) async {
    var name = basename(document.path);
    var response = await _dio.post(
      'company/$companyId/$name',
      data: await document.readAsBytes(),
    );
    return ApiResponse<DocumentModel>.fromJson(
        response.data, (p0) => DocumentModel.fromJson(p0 as dynamic));
  }

  @override
  Future<ApiResponse<List<DocumentModel>>> getDocuments({
    required int companyId,
  }) async {
    var response = await _dio.get('company/$companyId/documents');
    return ApiResponse<List<DocumentModel>>.fromJson(response.data, (p0) {
      List<DocumentModel> documents = [];
      for (var json in (p0 as List<dynamic>)) {
        documents.add(DocumentModel.fromJson(json));
      }
      return documents;
    });
  }

  @override
  Future<File> retreiveDocument({required String path}) async {
    var tmpDir = await getTemporaryDirectory();
    var savePath = join(tmpDir.path, basename(path));
    await _dio.download('/documents/$path', savePath);
    return File(savePath);
  }
}
