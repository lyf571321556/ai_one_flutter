//import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:flustars/flustars.dart';
import 'package:ones_ai_flutter/ui/drawers/main_left_page.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';

class HomePage extends StatelessWidget {
  static final String pageName = "HomePage";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
        tag: Config.LOGIN_HERO_TAG,
        child: Container(
          decoration: BoxDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            resizeToAvoidBottomPadding: true,
            appBar: MyAppBar(
              elevation: 1,
              leading: Config.runInWeb
                  ? Image.network(
                      StoreProvider.of<OnesGlobalState>(context)
                          .state
                          .user
                          .avatar,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: StoreProvider.of<OnesGlobalState>(context)
                          .state
                          .user
                          .avatar,
                      imageBuilder: (context, imageProvider) => Container(
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
              title: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                constraints: BoxConstraints.expand(),
                margin: EdgeInsets.only(top: 0),
                //MediaQuery.of(context).size.height * 0.008
                padding: EdgeInsets.all(0),
                //MediaQuery.of(context).size.height * 0.007
                alignment: Alignment.center,
                child: Text(
                  "标题",
                  style: TextStyle(color: Colors.white),
                ), //IntlUtil.getString(context, Strings.home_title)
              ),
//          title: TabLayout(),

              centerTitle: true,
              actions: <Widget>[
                new IconButton(icon: new Icon(Icons.search), onPressed: () {})
              ],
            ),
            body: HomePageContent(),
//        body: new TabBarViewLayout(),
            drawer: new Drawer(
              child: MainLeftMenuPage(),
            ),
          ),
        ));
  }
}

class HomePageContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageContentState();
  }
}

class _HomePageContentState extends State<HomePageContent> {
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      child: Container(
        constraints: BoxConstraints.expand(),
        alignment: Alignment.center,
        child: Text(IntlUtil.getString(context, Strings.titleHome)),
      ),
    );
  }
}

class _Page {
  final String labelId;

  _Page(this.labelId);
}

final List<_Page> _allPages = <_Page>[
  new _Page(Strings.titleHome),
];

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.all(12.0),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _allPages
          .map((_Page page) =>
              new Tab(text: IntlUtil.getString(context, page.labelId)))
          .toList(),
    );
  }
}

class TabBarViewLayout extends StatelessWidget {
  Widget buildTabView(BuildContext context, _Page page) {
    String labelId = page.labelId;
    switch (labelId) {
      case Strings.titleHome:
        return Container(
          color: Colors.red,
        );
        break;
      default:
        return Container();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.e("TabBarViewLayout build.......");
    return new TabBarView(
        children: _allPages.map((_Page page) {
      return buildTabView(context, page);
    }).toList());
  }
}
