import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/utils/common_utils.dart';
import 'package:ones_ai_flutter/resources/index.dart';

class AppDao {
  static Future<dynamic> initApp(Store store) async {
    ///切换语言
    String localInfo = await LocalStorage.get(Config.LOCALE);
    Locale newlocal = null;
    if (localInfo != null && localInfo.length != 0) {
      newlocal = new Locale(localInfo.split("-")[0], localInfo.split("-")[1]);
    }
    CommonUtils.changeLocale(store, newlocal);

    ThemeData newThemeData = ThemeData.light().copyWith(
      primaryColor: Colors.blueAccent,
      accentColor: Colors.blueAccent,
      indicatorColor: Colors.white,
    );

    String colorKey = await LocalStorage.get(Config.THEME_COLOR);
    if (colorKey != null && colorKey.length != 0) {
      newThemeData = ThemeData.light().copyWith(
        primaryColor: themeColorMap[colorKey],
        accentColor: themeColorMap[colorKey],
        indicatorColor: Colors.white,
      );
    }
    CommonUtils.changeTheme(store, newThemeData);
    return Future.value();
  }
}
