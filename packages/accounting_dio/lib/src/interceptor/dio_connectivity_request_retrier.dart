import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;
  DioConnectivityRequestRetrier(this.dio) : connectivity = Connectivity();

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (connectivityResult != ConnectivityResult.none) {
          streamSubscription.cancel();
          // Complete the completer instead of returning
          responseCompleter.complete(
            dio.get(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              onReceiveProgress: requestOptions.onReceiveProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                contentType: requestOptions.contentType,
                headers: requestOptions.headers,
                responseType: requestOptions.responseType,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
