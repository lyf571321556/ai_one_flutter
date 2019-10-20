import 'package:fluintl/fluintl.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/routes/page_route.dart';
import 'package:ones_ai_flutter/common/dao/app_dao.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/utils/navigator_utils.dart';
import 'package:ones_ai_flutter/ui/pages/home_page.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;

    ///防止多次初始化
////    Store<OnesGlobalState> store = StoreProvider.of(context);
//    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
//      AppDao.initApp(store).then((Void) {
//        NavigatorUtils.pushReplacementNamed(context, HomePage.pageName);
//        return true;
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return StoreBuilder<OnesGlobalState>(builder: (context, store) {
      return Material(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: InkWell(
              child: Center(
                child: Text(IntlUtil.getString(context, Strings.jumpCount,
                    params: [0, "111"])),
              ),
              onTap: () {
                String routePath = store.state.user != null
                    ? PageRouteManager.homePagePath
                    : PageRouteManager.loginPagePath;
                PageRouteManager.openNewPage(context, routePath);
              },
            )),
      );
    });
  }
}
