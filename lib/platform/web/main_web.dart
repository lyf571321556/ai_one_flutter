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
  html.window.document.cookie =
      "uid=${user.uuid};expires=Thu, 18 Dec 2020 12:00:00 UTC";
  html.window.document.cookie =
      "lt=${user.token};expires=Thu, 18 Dec 2020 12:00:00 UTC";
  CommonUtils.changeUser(store, user);
}

_localStorage() {
  html.window.localStorage['local_value'] = "";
}

_sessionStore() {
  html.window.sessionStorage['session_value'] = "";
}

Future<String> getCurrentRequestUrl() {
  print(html.window.location.hash);
  print(html.window.location.href);
  print(html.window.location.origin);
  return Future.value(html.window.location.toString());
}

String getCurrentRequestUrlPath() {
  return html.window.location.hash.replaceAll("#", "");
}

String goToDestPage(String url) {
//  html.window.open("https://dev.myones.net/wiki/master/#/team/YcGYa2G4/space/PmCBHfN2/page/VmtPK2vC", "窗口");
  html.window.location.href =
      "https://dev.myones.net/wiki/master/#/team/YcGYa2G4/space/PmCBHfN2/page/VmtPK2vC";
}
