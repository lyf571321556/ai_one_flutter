import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ones_ai_flutter/common/bloc/bloc_widget.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/project_list_bloc.dart';

class ProjectListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectListPageContentState();
  }
}

class _ProjectListPageContentState extends State<ProjectListPage>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _refreshController;
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = EasyRefreshController();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    print("ComListPage build......");
    final ProjectListBloc _projectListBloc =
        BlocListProviderWidget.of<ProjectListBloc>(context);
    _projectListBloc.projectListEventStream.listen((action) {
      switch (action) {
        case ListAction.RefreshAction:
          _refreshController.finishRefresh(success: true);
          print("_refreshController.refreshCompleted");
          break;
        case ListAction.LoadAction:
          _refreshController.finishLoad(success: true);
          print("_refreshController.loadComplete");
          break;
      }
    });
    return StreamBuilder(
      stream: _projectListBloc.projectListStream,
      builder: (context, snapshot) {
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
            return _projectListBloc.onLoadMore();
          },
          onRefresh: () {
            return _projectListBloc.onRefresh();
          },
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              itemExtent: 100,
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(snapshot.data[index]),
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
