import 'package:flutter/material.dart';
import 'package:redux/redux.dart';


final ThemeDataReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData, ChangeThemeDataAction>(_changeTheme),
]);

ThemeData _changeTheme(ThemeData themeData, action) {
  themeData = action.themeData;
  return themeData;
}

class ChangeThemeDataAction {
  final ThemeData themeData;

  ChangeThemeDataAction(this.themeData);
}
