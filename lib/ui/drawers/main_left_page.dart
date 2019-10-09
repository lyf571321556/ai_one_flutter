import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/ui/pages/setting/language_page.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';

class MainLeftMenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainLeftMenuPageState();
  }
}

class PageInfo {
  PageInfo(this.titleId, this.iconData, this.page, [this.withScaffold = true]);

  String titleId;
  IconData iconData;
  Widget page;
  bool withScaffold;
}

class _MainLeftMenuPageState extends State<MainLeftMenuPage> {
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
        _pageInfo.add(PageInfo(Strings.titleLanguage, Icons.language, LanguageSelectPage()));

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

    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
            height: 166.0,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, left: 10.0),
            child: new Stack(
              children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      width: 64.0,
                      height: 64.0,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            ResourceUtils.getImgPath('default_avatar'),
                          ),
                        ),
                      ),
                    ),
                    new Text(
                      _userName,
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    new Text(
                      "个人简介",
                      style: new TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ],
                ),
                new Align(
                  alignment: Alignment.topRight,
                  child: new IconButton(
                      iconSize: 18.0,
                      icon: new Icon(Icons.edit, color: Colors.white),
                      onPressed: () {}),
                )
              ],
            ),
          ),
          new Container(
            height: 50.0,
            child: new Material(
              color: Colors.grey[200],
              child: new InkWell(
                onTap: () {

                },
                child: new Center(
                  child: new Text(
                    "divider",
                    style: new TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: new ListView.builder(
                padding: const EdgeInsets.all(0.0),
                itemCount: _pageInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  PageInfo pageInfo = _pageInfo[index];
                  return new ListTile(
                    leading: new Icon(pageInfo.iconData),
                    title: Text(IntlUtil.getString(context, pageInfo.titleId)),
                    onTap: () {
                      NavigatorUtils.pushPage(context, pageInfo.page);
                    },
                  );
                }),
            flex: 1,
          )
        ],
      ),
    );
  }
}
