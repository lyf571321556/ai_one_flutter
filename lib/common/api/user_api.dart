import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/net/dio/http_manager.dart';
import 'package:ones_ai_flutter/common/net/dio/http_result.dart';
import 'package:ones_ai_flutter/models/account/index.dart';

class UserApi {
  static final String LOGIN_URL = "project/master/auth/login";

  static Future<HttpResult> login(
      String userName, String password, CancelToken token) async {
    Map<String, dynamic> bodyParams = {
      "password": password,
      "email": userName,
    };
    dynamic data = await HttpManager.getInstance()
        .post(LOGIN_URL, bodyParams: bodyParams)
        .then((result) {
      if (result.isSuccess) {
        result.data = User.fromJson(result.data["user"]);
      }
      return result;
    }).catchError((e){

    });
    return Future.value(data);
  }
}
