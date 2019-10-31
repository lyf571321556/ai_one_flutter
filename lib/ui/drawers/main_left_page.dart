import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluintl/fluintl.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/dao/user_dao.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/common/routes/page_route.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/ui/pages/setting/language_page.dart';
import 'package:ones_ai_flutter/ui/pages/setting/theme_page.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';
import 'package:redux/redux.dart';

class MainLeftMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainLeftMenuPageState();
  }
}

class PageInfo {
  PageInfo(this.titleId, this.iconData, this.pagePath,
      [this.withScaffold = true]);

  String titleId;
  IconData iconData;
  String pagePath;
  bool withScaffold;
}

class _MainLeftMenuPageState extends State<MainLeftMenuPage> {
  int currentPageIndex = 0;
  List<PageInfo> _pageInfo = new List();
  PageInfo loginOut =
      PageInfo(Strings.titleHome, Icons.power_settings_new, null);
  String _userName = "";

  @override
  void initState() {
    super.initState();
    /**
        _pageInfo.add(PageInfo(
        Strings.titleHome,
        Icons.collections,
        new CollectionPage(
        labelId: Strings.titleHome,
        ),
        )); */
    _pageInfo.add(PageInfo(Strings.titleLanguage, Icons.language,
        PageRouteManager.languagePagePath));
    _pageInfo.add(PageInfo(
        Strings.titleTheme, Icons.color_lens, PageRouteManager.themePagePath));
    _pageInfo.add(PageInfo(Strings.titleLoginOut, Icons.exit_to_app, null));
  }

  @override
  Widget build(BuildContext context) {
    /*
    if (Util.isLogin()) {
      if (!_pageInfo.contains(loginOut)) {
        _pageInfo.add(loginOut);
        UserModel userModel =
            SpHelper.getObject<UserModel>(BaseConstant.keyUserModel);
        _userName = userModel?.username ?? "";
        LogUtil.e("_userName : $_userName");
      }
    } else {
      _userName = "Sky24n";
      if (_pageInfo.contains(loginOut)) {
        _pageInfo.remove(loginOut);
      }
    }
    */
    Store<OnesGlobalState> store = StoreProvider.of(context);
    return new Column(
      children: <Widget>[
        new Container(
          height: 180.0,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: 10.0),
          child: new Stack(
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: 60.0,
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          ResourceUtils.getImgPath('default_avatar'),
                        ),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: StoreProvider.of<OnesGlobalState>(context)
                          .state
                          .user
                          .avatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 6),
                  new Text(
                    "部门/职位",
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  new Text(
                    StoreProvider.of<OnesGlobalState>(context).state.user.name,
                    style: new TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ],
              ),
              new Align(
                alignment: Alignment.topRight,
                child: new IconButton(
                    iconSize: 18.0,
                    icon:
                        new Icon(Icons.edit, color: Colors.white.withAlpha(0)),
                    onPressed: () {}),
              )
            ],
          ),
        ),
//          new Container(
//            height: 50.0,
//            child: new Material(
//              color: Colors.grey[200],
//              child: new InkWell(
//                onTap: () {
//
//                },
//                child: new Center(
//                  child: new Text(
//                    "divider",
//                    style: new TextStyle(
//                        color: Theme.of(context).primaryColor, fontSize: 16.0),
//                  ),
//                ),
//              ),
//            ),
//          ),
        new Expanded(
          child: new ListView.builder(
              padding: const EdgeInsets.all(0.0),
              itemCount: _pageInfo.length,
              itemBuilder: (BuildContext context, int index) {
                PageInfo pageInfo = _pageInfo[index];
                return new ListTile(
                  leading: new Icon(pageInfo.iconData,
                      color: index == currentPageIndex
                          ? Theme.of(context).primaryColor
                          : null),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  title: Text(IntlUtil.getString(context, pageInfo.titleId)),
                  onTap: () async {
                    if (pageInfo.pagePath == null) {
                      await UserDao.saveLoginUserInfo(null, store);
                      PageRouteManager.openNewPage(
                          context, PageRouteManager.loginPagePath,
                          replace: true);
                    } else {
                      PageRouteManager.openNewPage(context, pageInfo.pagePath);
                    }
                  },
                );
              }),
          flex: 1,
        )
      ],
    );
  }
}
