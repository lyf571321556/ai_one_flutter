import 'dart:convert';

import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/models/account/index.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';
import 'package:redux/redux.dart';

///获取本地登录用户信息
class UserDao {
  static getUserInfo() async {
    var userText = LocalDataHelper.get(Config.USER_INFO);
    if (userText != null) {
      Map<String, dynamic> userMap = json.decode(userText);
      User user = User.fromJson(userMap);
      return Future.value(user);
    } else {
      return Future.value(null);
    }
  }

  static saveLoginUserInfo(User user, Store store) async {
    bool result = await LocalDataHelper.put(
        Config.USER_INFO, user == null ? null : json.encode(user.toJson()));
    CommonUtils.changeUser(store, user);
    return result;
  }
}
