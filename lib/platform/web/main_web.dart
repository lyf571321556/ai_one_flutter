import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'dart:html' as html;

import 'package:ones_ai_flutter/models/account/user.dart';
import 'package:ones_ai_flutter/utils/common_utils.dart';
import 'package:redux/redux.dart';

void initByPlatform() {
  Config.runInWeb = identical(0, 0.0);
}

Future<bool> isConnected() async {
  return true;
}

void initProxy(Dio _dio) {}

void saveToken(User user, Store store) async {
  print(user.toJson());
  html.window.document.cookie = "uid=${user.uuid};lt=${user.token}";
  CommonUtils.changeUser(store, user);
}


_localStorage() {
  html.window.localStorage['local_value'] = "";
}
_sessionStore() {
  html.window.sessionStorage['session_value'] = "";
}