import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/net/dio/http_manager.dart';
import 'package:ones_ai_flutter/common/net/graphql/graphql_manager.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/common/redux/global/locale_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
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

ThunkAction<OnesGlobalState> LoginUserSateMiddleware =
    (Store<OnesGlobalState> store) async {};
final List<Middleware<OnesGlobalState>> onesMiddlewares = [
  thunkMiddleware,
  new LoginUserMiddleware()
];

class LoginUserMiddleware implements MiddlewareClass<OnesGlobalState> {
  @override
  void call(Store<OnesGlobalState> store, dynamic action, NextDispatcher next) {
    if (action is UserChangeActioin) {
      print("*********** UserChangeActioin  Middleware start*********** ");
      if (store.state.user != null) {
        HttpManager.getInstance()
            .initAuthorization(store.state.user.uuid, store.state.user.token);
        GraphqlManager.getInstance()
            .initAuthorization(store.state.user.uuid, store.state.user.token);
      } else {
//        HttpManager.getInstance().clearAuthorization();
//        GraphqlManager.getInstance().clearAuthorization();
      }
      print("*********** UserChangeActioin  Middleware end*********** ");
    }
    next(action);
  }
}
