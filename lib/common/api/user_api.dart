import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/net/http_manager.dart';
import 'package:ones_ai_flutter/models/index.dart';

class UserApi {
  static final String LOGIN_URL = "project/master/auth/login";

  static Future<User> login(
      String userName, String password, CancelToken token) async {
    Map<String, dynamic> requestParams = {
      "password": password,
      "email": userName,
    };
    User user = await HttpManager.getInstance()
        .post<Map>(
      LOGIN_URL,
      bodyParams: requestParams,
    )
        .then<User>((response) {
      return Future.value(User.fromJson(response.data["user"]));
    });

    return Future.value(user);
  }
}
