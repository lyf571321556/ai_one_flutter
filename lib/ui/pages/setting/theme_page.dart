import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/common/routes/page_route.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';
import 'package:redux/redux.dart';

class ThemeSelectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThemeSelectPageState();
  }
}

class _ThemeSelectPageState extends State<ThemeSelectPage> {
  List<String> list = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = themeColorMap.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: StoreBuilder<OnesGlobalState>(builder: (context, store) {
        return Scaffold(
          appBar: new AppBar(
            title: new Text(
              IntlUtil.getString(context, Strings.changeTheme),
              style: new TextStyle(fontSize: 16.0),
            ),
            actions: <Widget>[],
          ),
          body: Container(
            alignment: Alignment.topCenter,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _buildItem(context, index, store);
              },
            ),
          ),
        );
      }),
    );
  }

  void _changeTheme(String key, Store<OnesGlobalState> store) {
    ThemeData newThemeData = ThemeData.light().copyWith(
        primaryColor: themeColorMap[key],
        accentColor: themeColorMap[key],
        indicatorColor: themeColorMap[key],
        platform: TargetPlatform.iOS);
    CommonUtils.changeTheme(store, newThemeData);
    LocalDataHelper.put(Config.THEME_COLOR, key);
    setState(() {});
    PageRouteManager.closePage(context);
  }

  Widget _buildItem(
      BuildContext context, int index, Store<OnesGlobalState> store) {
    String key = list[index];
    Color color = themeColorMap[key];
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AbsorbPointer(
          absorbing: color == store.state.themeData.primaryColor,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: () {
              _changeTheme(key, store);
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: Text(
                key,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, letterSpacing: 1, wordSpacing: 1),
              ),
              constraints: BoxConstraints(maxHeight: 80, maxWidth: 80),
              decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ),
        Positioned(
          child: AbsorbPointer(
            absorbing: false,
            child: Opacity(
              opacity: 0,
              child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    //do nothing
                  }),
            ),
          ),
          top: 0,
          right: 0,
        )
      ],
    );
  }
}
