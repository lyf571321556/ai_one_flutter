import 'dart:collection';

import 'package:ones_ai_flutter/common/bloc/bloc_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class ProjectListBloc implements BlocListBase {
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

  Sink<int> get _projectListInTotalFavorites =>
      _projectListTotalController.sink;

  Stream<int> get rojectListOutTotalFavorites =>
      _projectListTotalController.stream;

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
  Future onLoadMore({Map params}) {
    // TODO: implement onLoadMore
    print("onLoadMore");
    _projectList.add("2");
    _projectListSink.add(UnmodifiableListView<String>(_projectList));
    _projectListEventSink.add(ListAction.LoadAction);
//    _notify();
  }

  @override
  Future onRefresh({Map params}) {
    // TODO: implement onRefresh
    print("onRefresh");
    _projectList.add("3");
    _projectListSink.add(UnmodifiableListView<String>(_projectList));
    _projectListEventSink.add(ListAction.RefreshActin);
//    _notify();
  }

  void _notify() {
    // The total number of projects
    _projectListInTotalFavorites.add(_projectList.length);
  }
}
