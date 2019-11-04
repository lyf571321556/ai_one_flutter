import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/dao/user_dao.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/models/account/user.dart';

class TokenInterceptor extends InterceptorsWrapper {
  String _userId, _token;

  @override
  onRequest(RequestOptions options) async {
    if (_token == null || _userId == null) {
      User user = await UserDao.getUserInfo()();
      if (user != null) {
        _token = user.token;
        _userId = user.uuid;
      }
    }
    options.headers["Ones-User-Id"] = _userId;
    options.headers["Ones-Auth-Token"] = _token;
    options.contentType = "application/json";
    return options;
  }

//
//  @override
//  onResponse(Response response) async {
//    try {
//      var responseJson = response.data;
//      if (response.statusCode == 200 && responseJson["token"] != null) {
//        _token = 'token ' + responseJson["token"];
//        await LocalStorage.save(Config.TOKEN_KEY, _token);
//      }
//    } catch (e) {
//      print(e);
//    }
//    return response;
//  }

  ///清除授权
  clearAuthorization() {
    this._userId = null;
    this._token = null;
  }
}
