import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/common/redux/global/locale_redux.dart';
import 'theme_redux.dart';

/**

 */

///global redux store
class OnesGlobalState {
  Locale platformLocale;

  Locale locale;

  ThemeData themeData;

  OnesGlobalState({this.locale, this.themeData,this.platformLocale});
}

//create Reducer

OnesGlobalState createOnesAppReducer(OnesGlobalState onesState, action) {
  return OnesGlobalState(
      locale: LocaleReducer(onesState.locale, action),
      themeData: ThemeDataReducer(onesState.themeData, action));
}

//reducer Middleware

final List<Middleware<OnesGlobalState>> onesMiddlewares = [];
