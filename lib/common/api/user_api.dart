import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/net/http_manager.dart';
import 'package:ones_ai_flutter/models/index.dart';

class UserResultCallBack extends ResultCallBack<Response, User> {
  @override
  onError(Response error) {
    // TODO: implement onError
    print("error:"+error.toString());
  }

  @override
  OnSuccess(User data) {
    // TODO: implement OnSuccess
    print(data.email);
  }
}

class UserApi {
  static final String LOGIN_URL = "project/master/auth/login";

  static Future<User> login(
      String userName, String password, CancelToken token) async {
    Map<String, dynamic> requestParams = {
      "password": password,
      "email": userName,
    };
    User user = await HttpManager.getInstance().post(
      LOGIN_URL,
      (response) {
        if(response==null){
          return Future.value(null);
        }
        return Future.value(User.fromJson(response.data["user"]));
      },
      UserResultCallBack(),
      bodyParams: requestParams,
    );

    return Future.value(user);
  }
}
