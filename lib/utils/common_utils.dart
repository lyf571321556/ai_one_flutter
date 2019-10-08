import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/global/redux/ones_state.dart';
import 'package:ones_ai_flutter/global/redux/locale_redux.dart';

class CommonUtils {
  static Locale curLocale;

  static changeLocale(Store<OnesGlobalState> store, Locale newlocale) {
    Locale locale = store.state.platformLocale;
    if (newlocale != null) {
      locale = newlocale;
    }
    store.dispatch(ChangeLocaleAction(locale));
  }
}
