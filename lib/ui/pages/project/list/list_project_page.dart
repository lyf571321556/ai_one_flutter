import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ones_ai_flutter/common/bloc/bloc_widget.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/list_project_bloc.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/list_project_event.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/list_project_state.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/project_list_bloc.dart';

class ListProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ListProjectPageContentState();
  }
}

class _ListProjectPageContentState extends State<ListProjectPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController;
  ScrollController _scrollController;
  ListProjectBloc _listProjectBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = EasyRefreshController();
    _scrollController = ScrollController();
    _listProjectBloc = BlocProvider.of<ListProjectBloc>(context);
    _listProjectBloc.listen((state) {
      if (state is ListProjectRefreshedState) {
        _refreshController.finishRefresh(success: true);
        print("_refreshController.refreshCompleted");
      } else if (state is ListProjectLoadedState) {
        _refreshController.finishLoad(success: true);
        print("_refreshController.loadComplete");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("ComListPage build......");
    return BlocConsumer<ListProjectBloc, ListProjectState>(
      listenWhen: (previous, current) {
        //监听哪些状态
        return true;
      },
      listener: (context, state) {
        print("监听状态变化!");
      },
      buildWhen: (previous, current) {
        //根据状态决定是否重新渲染UI
        return current is ListProjectLoadedState ||
            current is ListProjectRefreshedState;
      },
      builder: (context, state) {
        List<String> data = [];
        if (state is ListProjectLoadedState) {
          data = state.dataSource;
        } else if (state is ListProjectRefreshedState) {
          data = state.dataSource;
        }
        return EasyRefresh(
          controller: _refreshController,
          scrollController: _scrollController,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          header: BezierCircleHeader(
              backgroundColor: Theme.of(context).primaryColor),
          footer: BezierBounceFooter(
              backgroundColor: Theme.of(context).primaryColor),
          onLoad: () {
            _listProjectBloc.add(ListProjectLoadMoreEvent());
            return Future.value();
          },
          onRefresh: () {
            _listProjectBloc.add(ListProjectRefreshEvent());
            return Future.value();
          },
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              itemExtent: 100,
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(data[index]),
                );
              }),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
