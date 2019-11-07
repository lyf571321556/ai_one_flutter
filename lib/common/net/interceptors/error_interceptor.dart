import 'package:dio/dio.dart';

import '../dio/http_code.dart';

import 'package:ones_ai_flutter/platform/web/main_web.dart'
    if (dart.library.io) "package:ones_ai_flutter/platform/mobile/main_mobile.dart";

class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {
    bool connected = await isConnected();
    if (!connected) {
      return _dio
          .resolve(new Response(statusCode: HttpCode.INVALID_NETWORK_CODE));
    }
    return options;
  }
}
