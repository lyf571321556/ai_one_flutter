//import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/bloc/bloc_widget.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/ui/drawers/main_left_page.dart';
import 'package:ones_ai_flutter/ui/pages/dashboard/list/dashboard_page.dart';
import 'package:ones_ai_flutter/ui/pages/notification/list/notification_list_page.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/list_project_bloc.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/list_project_page.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/project_list_bloc.dart';
import 'package:ones_ai_flutter/ui/pages/project/list/project_list_page.dart';
import 'package:ones_ai_flutter/ui/pages/wiki/list/wiki_list_page.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';

class HomePage extends StatefulWidget {
  static final String pageName = "HomePage";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageContentState();
  }
}

class _ChildPage {
  final String labelId;
  final String iconId;

  _ChildPage(this.labelId, this.iconId);
}

final List<_ChildPage> _allChildPages = <_ChildPage>[
  new _ChildPage(Strings.titleProject, Drawables.PROJECT_ICON),
  new _ChildPage(Strings.titleWiki, Drawables.WIKI_ICON),
  new _ChildPage(Strings.titleDashboard, Drawables.DASHBOARD_ICON),
  new _ChildPage(Strings.titleNotification, Drawables.NOTIFICATION_ICON),
];

class _HomePageContentState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  DateTime _lastPressedAt;
  TabController _tabController;
  GlobalKey<_NavigationBarState> _NavigationBarStateKey = GlobalKey();
  GlobalKey<_TitleBarWidgetState> _TitleBarWidgetStateKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController =
        new TabController(vsync: this, length: _allChildPages.length);
    _tabController.addListener(() {
      _NavigationBarStateKey.currentState.changeTo(_tabController.index);
      _TitleBarWidgetStateKey.currentState.ssetTitle(IntlUtil.getString(
          context, _allChildPages[_tabController.index].labelId));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String avatar =
        StoreProvider.of<OnesGlobalState>(context).state.user?.avatar;
    return WillPopScope(
      onWillPop: () async {
        if (Scaffold.of(context).isDrawerOpen) {
          Scaffold.of(context).openEndDrawer();
          return false;
        }
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
//          BotToast.showText(
//              text: IntlUtil.getString(context, Strings.exitApp),
//              backgroundColor: Colors.grey);
          return false;
        } else {
          return true;
        }
      },
      child: Hero(
        tag: Config.LOGIN_HERO_TAG,
        child: Scaffold(
          appBar: PreferredSize(
            child: AppBar(
              elevation: 1,
              leading: Config.runInWeb
                  ? Image.network(
                      avatar == null ? "" : avatar,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: avatar == null ? "" : avatar,
                      imageBuilder: (context, imageProvider) => Container(
                        constraints:
                            BoxConstraints.tightFor(width: 50, height: 50),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) {
                        return Container(
                          constraints:
                              BoxConstraints.tightFor(width: 50, height: 50),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                ResourceUtils.getImgPath('default_avatar'),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
              title: TitleBarWidget(
                key: _TitleBarWidgetStateKey,
                title: IntlUtil.getString(
                    context, _allChildPages[_tabController.index].labelId),
              ),
//                title: NavigationBarWidget(_tabController),
              centerTitle: false,
              actions: <Widget>[
                new IconButton(icon: new Icon(Icons.search), onPressed: () {})
              ],
            ),
            preferredSize: Size(double.infinity, 55),
          ),
          body: TabContentViewWidget(_tabController),
          drawer: new Drawer(
            child: MainLeftMenuPage(),
          ),
          bottomNavigationBar: NavigationBarWidget(
            _tabController,
            key: _NavigationBarStateKey,
          ),
        ),
      ),
    );
  }
}

class TitleBarWidget extends StatefulWidget {
  final String title;

  TitleBarWidget({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TitleBarWidgetState(title);
  }
}

class _TitleBarWidgetState extends State<TitleBarWidget> {
  String _title;

  _TitleBarWidgetState(this._title) : super();

  void ssetTitle(String title) {
    setState(() {
      _title = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      constraints: BoxConstraints.expand(),
      margin: EdgeInsets.only(top: 0),
      //MediaQuery.of(context).size.height * 0.008
      padding: EdgeInsets.all(0),
      //MediaQuery.of(context).size.height * 0.007
      alignment: Alignment.centerLeft,
      child: Text(
        _title,
        style: TextStyle(color: Colors.white),
      ), //IntlUtil.getString(context, Strings.home_title)
    );
  }
}

class NavigationBarWidget extends StatefulWidget {
  TabController _tabController;

  NavigationBarWidget(this._tabController, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NavigationBarState();
  }
}

class _NavigationBarState extends State<NavigationBarWidget> {
  static int _currentIndex = 0;

  void changeTo(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: SafeArea(
//          child:
//          CupertinoTabBar(
//        currentIndex: _currentIndex,
//        backgroundColor: Colors.white,
//        items: _allChildPages
//            .map((_ChildPage page) => BottomNavigationBarItem(
//                icon: new Icon(Icons.assignment, size: 20.0),
//                title: Text(IntlUtil.getString(context, page.labelId)),
//                activeIcon: new Icon(
//                  Icons.assignment,
//                  size: 20.0,
//                  color: Colors.blueAccent,
//                )))
//            .toList(),
          child: TabBar(
        controller: widget._tabController,
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: _allChildPages
            .map((_ChildPage page) => new Tab(
                  icon: Icon(
                    Icons.home,
                    size: 25.0,
                    color: Colors.blue,
                  ),
                  text: IntlUtil.getString(
                    context,
                    page.labelId,
                  ),
//                  child: new Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      new Icon(Icons.home, size: 25.0,color:Colors.blue,),
//                      new Text(
//                        ,
//                        style: TextStyle(color: Colors.black26),
//                      )
//                    ],
//                  ),
                ))
            .toList(),
        onTap: (index) {
          widget._tabController?.animateTo(index);
          setState(() {
            _currentIndex = index;
          });
        },
      )),
    );
  }
}

class TabContentViewWidget extends StatelessWidget {
  TabController _tabController;

  TabContentViewWidget(this._tabController, {Key key}) : super(key: key);

  Widget buildTabView(BuildContext context, _ChildPage page) {
    String labelId = page.labelId;
    switch (labelId) {
      case Strings.titleProject:
//        return BlocListProviderWidget(
//          bloc: ProjectListBloc(),
//          child: ProjectListPage(),
//        );
        return BlocProvider(
          create: (context) {
            return ListProjectBloc();
          },
          child: ListProjectPage(),
        );
        break;
      case Strings.titleWiki:
        return WikiListPage();
        break;
      case Strings.titleDashboard:
        return DashboardPage();
        break;
      case Strings.titleNotification:
        return NotificationListPage();
        break;
      default:
        return Container();
        break;
    }
  }

  @override
  Widget buildBuildContext(context) {
//    like fragment
//    return IndexedStack(
//      children: _allChildPages.map((_ChildPage page) {
//        return buildTabView(context, page);
//      }).toList(),
//      index: _currentIndex,
//    );
    return new TabBarView(
        controller: _tabController,
        children: _allChildPages.map((_ChildPage page) {
          return buildTabView(context, page);
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new TabBarView(
        controller: _tabController,
        children: _allChildPages.map((_ChildPage page) {
          return buildTabView(context, page);
        }).toList());
  }
}
