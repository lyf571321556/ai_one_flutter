import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/net/http_manager.dart';
import 'package:ones_ai_flutter/models/account/index.dart';

class UserResultCallBack implements ResultCallBack<Response, User> {
  @override
  onError(Response error) {
    // TODO: implement onError
    print("error:" + error.statusMessage);
    print("errorCode:" + error.statusCode.toString());
  }

  @override
  OnSuccess(User data) {
    // TODO: implement OnSuccess
    print(data.email);

  }

  @override
  User onParseData(Response response) {
    // TODO: implement onParseData
    if (response == null) {
      return null;
    }
    return User.fromJson(response.data["user"]);
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

    User user = await HttpManager.getInstance().post<User>(LOGIN_URL,
        resultCallBack: UserResultCallBack(), bodyParams: requestParams);

    return Future.value(user);
  }
}
