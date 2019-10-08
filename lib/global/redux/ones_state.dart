import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'locale_redux.dart';
/**

 */

///global redux store
class OnesGlobalState {
  Locale platformLocale;

  Locale locale;

  OnesGlobalState({this.locale});
}

//create Reducer

OnesGlobalState createOnesAppReducer(OnesGlobalState onesState, action) {
  return OnesGlobalState(locale: LocaleReducer(onesState.locale, action));
}

//reducer Middleware

final List<Middleware<OnesGlobalState>> onesMiddlewares = [];
