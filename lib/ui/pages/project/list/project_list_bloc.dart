import 'dart:collection';
import 'dart:math';

import 'package:ones_ai_flutter/common/bloc/bloc_widget.dart';
import 'package:ones_ai_flutter/common/database/database.dart';
import 'package:ones_ai_flutter/common/database/platform/index.dart';
import 'package:rxdart/rxdart.dart';
@deprecated
class ProjectListBloc implements BlocListBase {
  Database db;

  ProjectListBloc() {
    db = createDatabase();
  }

  //get list interfase
  BehaviorSubject<List<String>> _projectListData =
      BehaviorSubject<List<String>>();

  Sink<List<String>> get _projectListSink => _projectListData.sink;

  Stream<List<String>> get projectListStream => _projectListData.stream;

  //status event interface
  BehaviorSubject<ListAction> _projectListEvent = BehaviorSubject<ListAction>();

  Sink<ListAction> get _projectListEventSink => _projectListEvent.sink;

  Stream<ListAction> get projectListEventStream =>
      _projectListEvent.stream.asBroadcastStream();

  // get  the total number of projects  interfase
  BehaviorSubject<int> _projectListTotalController = new BehaviorSubject<int>();

  Sink<int> get _projectListInTotal => _projectListTotalController.sink;

  Stream<int> get rojectListOutTotal => _projectListTotalController.stream;

  List<String> _projectList = new List();

  @override
  void dispose() {
    _projectListData.close();
  }

  @override
  Future getData({Map params}) {
    // TODO: implement getData
    _projectList.add("data");
    _notify();
    return null;
  }

  @override
  Future onLoadMore({Map params}) async {
    // TODO: implement onLoadMore
    print("onLoadMore");
    await Future.delayed(Duration(milliseconds: 500));
    String result = Random().nextInt(1000).toString();
    print(result);
    _projectList.add(result);
    print(_projectList.length);
    _projectListSink.add(UnmodifiableListView<String>(_projectList));
    _projectListEventSink.add(ListAction.LoadAction);
    _notify();
  }

  @override
  Future onRefresh({Map params}) async {
    // TODO: implement onRefresh
    print("onRefresh");
    List<User> allUsers= await db.queryAllUsers(10,offset: 0);
    allUsers.forEach((element) {
      print(element);
    });
    print("user'size is ${allUsers.length}");
    await Future.delayed(Duration(milliseconds: 500));
    String result = Random().nextInt(1000).toString();
    print(result);
    _projectList.add(result);
    print(_projectList.length);
    _projectListSink.add(UnmodifiableListView<String>(_projectList));
    _projectListEventSink.add(ListAction.RefreshAction);
    _notify();
  }

  void _notify() {
    // The total number of projects
    _projectListInTotal.add(_projectList.length);
  }
}
