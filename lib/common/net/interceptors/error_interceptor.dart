import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import '../dio/http_code.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio
          .resolve(new Response(statusCode: HttpCode.INVALID_NETWORK_CODE));
    }
    return options;
  }
}
