import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/models/account/index.dart';

final UserReducer = combineReducers<User>([
  TypedReducer<User, UserChangeActioin>(_changeUser),
]);

User _changeUser(User user, UserChangeActioin action) {
  user = action.user;
  return user;
}

class UserChangeActioin {
  final User user;

  UserChangeActioin(this.user);
}
