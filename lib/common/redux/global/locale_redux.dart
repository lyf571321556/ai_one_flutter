import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

final LocaleReducer = combineReducers<Locale>([
  TypedReducer<Locale, ChangeLocaleAction>(_changeLocal),
]);

Locale _changeLocal(Locale locale, ChangeLocaleAction action) {
  locale = action.locale;
  return locale;
}

class ChangeLocaleAction {
  final Locale locale;

  ChangeLocaleAction(this.locale);
}

final PlatformLocaleReducer = combineReducers<Locale>([
  TypedReducer<Locale, ChangePlatformLocaleAction>(_changePlatformLocale),
]);

Locale _changePlatformLocale(Locale locale, ChangePlatformLocaleAction action) {
  locale = action.locale;
  return locale;
}

class ChangePlatformLocaleAction {
  final Locale locale;

  ChangePlatformLocaleAction(this.locale);
}
