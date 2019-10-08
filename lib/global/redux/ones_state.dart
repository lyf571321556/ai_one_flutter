import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'locale_redux.dart';
/**

 */

///global redux store
class OnesAppState {
  ///语言
  Locale locale;

  OnesAppState({this.locale});
}

//create Reducer

OnesAppState createOnesAppReducer(OnesAppState onesState, action) {
  return OnesAppState(locale: LocaleReducer(onesState.locale, action));
}

//reducer Middleware

final List<Middleware<OnesAppState>> onesMiddlewares = [];
