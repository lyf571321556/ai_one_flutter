import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/dao/user_dao.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/models/account/index.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/utils/common_utils.dart';
import 'package:ones_ai_flutter/resources/index.dart';

class AppDao {
  static Future<Store<OnesGlobalState>> initApp(
      Store<OnesGlobalState> store) async {
    String userInfo =await LocalDataHelper.get(Config.USER_INFO);
    User user = null; //await UserDao.getUserInfo();
    if (userInfo != null) {
      Map<String, dynamic> userMap = json.decode(userInfo);
      user = User.fromJson(userMap);
    }
    CommonUtils.changeUser(store, user);

    ///切换语言
    String localInfo =await LocalDataHelper.get(Config.LOCALE);
    Locale newlocal = null;
    if (localInfo != null && localInfo.length != 0) {
      newlocal = new Locale(localInfo.split("-")[0], localInfo.split("-")[1]);
    }
    CommonUtils.changeLocale(store, newlocal);

    ThemeData newThemeData = ThemeData.light().copyWith(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.blueAccent,
        indicatorColor: Colors.white,
        platform: TargetPlatform.iOS);

    String colorKey =await LocalDataHelper.get(Config.THEME_COLOR);
    if (colorKey != null && colorKey.length != 0) {
      newThemeData = ThemeData.light().copyWith(
          primaryColor: themeColorMap[colorKey],
          accentColor: themeColorMap[colorKey],
          indicatorColor: Colors.white,
          platform: TargetPlatform.iOS);
    }
    CommonUtils.changeTheme(store, newThemeData);
    return Future.value(store);
  }
}
