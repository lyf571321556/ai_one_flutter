import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/common/redux/global/locale_redux.dart';
import 'theme_redux.dart';
import 'package:ones_ai_flutter/models/account/index.dart';
import 'user_redux.dart';

/**

 */

///global redux store
class OnesGlobalState {
  User user;

  Locale platformLocale;

  Locale locale;

  ThemeData themeData;

  OnesGlobalState(
      {this.locale, this.themeData, this.platformLocale, this.user});
}

//create Reducer

OnesGlobalState createOnesAppReducer(OnesGlobalState onesState, action) {
  return OnesGlobalState(
      user: UserReducer(onesState.user, action),
      locale: LocaleReducer(onesState.locale, action),
      themeData: ThemeDataReducer(onesState.themeData, action),
      platformLocale: PlatformLocaleReducer(onesState.platformLocale, action));
}

//reducer Middleware

final List<Middleware<OnesGlobalState>> onesMiddlewares = [];
