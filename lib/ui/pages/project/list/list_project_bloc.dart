import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ones_ai_flutter/common/database/database.dart';
import 'package:ones_ai_flutter/common/database/platform/index.dart';

import 'list_project_event.dart';
import 'list_project_state.dart';

class ListProjectBloc extends Bloc<ListProjectEvent, ListProjectState> {
  Database db;

  ListProjectBloc() {
    db = createDatabase();
  }

  @override
  // TODO: implement initialState
  get initialState => InitialListProjectState();
  List<String> _projectList = new List();

  @override
  Stream<ListProjectState> mapEventToState(event) async* {
    ListProjectState result;
    switch (event.runtimeType) {
      case ListProjectRefreshEvent:
        result = await refresh();
        break;
      case ListProjectLoadMoreEvent:
        result = await load();
        break;
    }
    yield result;
  }

  Future<ListProjectState> refresh() async {
    ListProjectState result;
    print("onRefresh");
    List<User> allUsers = await db.queryAllUsers(10, offset: 0);
    allUsers.forEach((element) {
      print(element);
    });
    print("user'size is ${allUsers.length}");
    await Future.delayed(Duration(milliseconds: 5000));
    String num = Random().nextInt(1000).toString();
    _projectList.add(num);
    result = ListProjectRefreshedState(_projectList);
    return result;
  }

  Future<ListProjectState> load() async {
    ListProjectState result;
    print("onLoad");
    List<User> allUsers = await db.queryAllUsers(10, offset: 0);
    allUsers.forEach((element) {
      print(element);
    });
    print("user'size is ${allUsers.length}");
    await Future.delayed(Duration(milliseconds: 5000));
    String num = Random().nextInt(1000).toString();
    _projectList.add(num);
    result = ListProjectLoadedState(_projectList);
    return result;
  }
}
