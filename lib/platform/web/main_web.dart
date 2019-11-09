import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';

void initByPlatform() {
  Config.runInWeb = identical(0, 0.0);
}

Future<bool> isConnected() async {
  return true;
}

void initProxy(Dio _dio) {}
