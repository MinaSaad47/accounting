import 'dart:io';

import 'package:accounting_api/accounting_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  final Connectivity _connectivity;
  DioInterceptor(this._connectivity);

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_isClientSide(err)) {
      if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
        var handlded = Response(
          requestOptions: err.requestOptions,
          data: const ApiResponse(
            status: false,
            message: 'لا يوجد انترنت',
            data: null,
          ).toJson((p0) => null),
        );
        return handler.resolve(handlded);
      } else {
        var handlded = Response(
          requestOptions: err.requestOptions,
          data: const ApiResponse(
            status: false,
            message: 'لم يتم الاتصال بالسيرفر',
            data: null,
          ).toJson((p0) => null),
        );
        return handler.resolve(handlded);
      }
    }
    // Let the error pass through if it's not the error we're looking for
    return err;
  }

  bool _isClientSide(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}
