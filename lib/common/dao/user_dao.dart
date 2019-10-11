import 'dart:convert';

import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/models/account/index.dart';

///获取本地登录用户信息
class UserDao {
  static getUserInfo() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return Future.value(user);
    } else {
      return Future.value(null);
    }
  }
}
