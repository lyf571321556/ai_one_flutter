import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/utils/common_utils.dart';

class AppDao {
  static Future<dynamic> initApp(Store store) async {
    ///切换语言
    String localInfo = await LocalStorage.get(Config.LOCALE);
    Locale newlocal = null;
    if (localInfo != null && localInfo.length != 0) {
      newlocal = new Locale(localInfo.split("-")[0], localInfo.split("-")[1]);
    }
    CommonUtils.changeLocale(store, newlocal);
    return Future.value();
  }
}
