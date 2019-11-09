import 'dart:async';

import 'package:auto_size/auto_size.dart';

//import 'package:bot_toast/bot_toast.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/dao/app_dao.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/ui/pages/home_page.dart';
import 'package:ones_ai_flutter/ui/pages/welcome_page.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/platform/web/main_web.dart'
    if (dart.library.io) "package:ones_ai_flutter/platform/mobile/main_mobile.dart";
import 'common/redux/global/locale_redux.dart';
import 'common/routes/page_route.dart';

void main() {
  runZoned(() {
    debugPaintSizeEnabled = !true;
    initByPlatform();
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
      return Container(color: Colors.transparent);
    };
//    WidgetsFlutterBinding.ensureInitialized();
    PageRouteManager.initRoutes();
//    SystemChrome.setEnabledSystemUIOverlays([]);
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);

//    runAutoSizeApp(OnesApp());
    runApp(OnesApp());
    PaintingBinding.instance.imageCache.maximumSize = 100;
  }, onError: (object, stack) {
    print("===============global error start===============");
    print(object);
    print(stack);
    print("===============global error end===============");
  });
}

class OnesApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OnesAppState();
  }
}

class OnesAppState extends State<OnesApp> {
  var _buildDataFuture;
  final Store onesStore = new Store<OnesGlobalState>(createOnesAppReducer,
      middleware: onesMiddlewares,
      initialState: new OnesGlobalState(
          themeData: ThemeData.light().copyWith(
              primaryColor: Colors.blueAccent,
              accentColor: Colors.blueAccent,
              indicatorColor: Colors.white,
              platform: TargetPlatform.iOS),
          platformLocale: WidgetsBinding.instance.window.locale));

  @override
  void initState() {
    // TODO: implement initState
    _buildDataFuture = AppDao.initApp(onesStore);
    super.initState();
    setLocalizedValues(localizedValues);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    Future.wait([AppDao.initApp(onesStore)]).then((Void) {
//      //do sometging
//      return true;
//    });
//    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
//      AppDao.initApp(onesStore).then((Void) {
//        NavigatorUtils.pushReplacementNamed(context, HomePage.pageName);
//        return true;
//      });
//    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: _buildWidgetBuilder,
      future: _buildDataFuture,
    );
  }

  Widget _buildWidgetBuilder(BuildContext context, AsyncSnapshot snapshot) {
    print("-------1--------");
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      print("-------2--------");
      return StoreProvider<OnesGlobalState>(
          store: snapshot.data,
          child: StoreBuilder<OnesGlobalState>(builder: (context, store) {
            return MaterialApp(
              onGenerateRoute: PageRouteManager.pageRouter.generator,
              debugShowCheckedModeBanner: false,
              title: 'Ones App',
              onGenerateTitle: (BuildContext context) {
                return IntlUtil.getString(context, Strings.titleHome);
              },
              locale: store.state.locale ?? store.state.platformLocale,
              supportedLocales: CustomLocalizations.supportedLocales,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                CustomLocalizations.delegate
              ],
              localeListResolutionCallback:
                  (List<Locale> locales, Iterable<Locale> supportedLocales) {
                if (locales.length <= 0 || store.state.locale != null) {
                  return;
                }
                if (localizedValues.containsKey(locales[0].languageCode)) {
                  if (store.state.platformLocale == null ||
                      locales[0].languageCode !=
                          store.state.platformLocale.languageCode ||
                      locales[0].countryCode !=
                          store.state.platformLocale.countryCode) {
                    store.state.platformLocale = locales[0];
//                        store.dispatch(ChangeLocaleAction(locales[0]));
                    store.dispatch(ChangePlatformLocaleAction(locales[0]));
                  }
                } else {
//                      store.dispatch(ChangeLocaleAction(supportedLocales.first));
                  store.dispatch(
                      ChangePlatformLocaleAction(supportedLocales.first));
                }
              },
              theme: store.state.themeData,
//                  routes: {
//                    HomePage.pageName: (context) {
//                      return new LocalizationsWidget(
//                        child: NavigatorUtils.pageContainer(new HomePage()),
//                      );
//                    }
//                  },
              home: _getHomePage(store.state.user != null),
            );
          }));
    } else {
      print("-------3--------");
      return Container(
        decoration: BoxDecoration(color: Colors.red),
      );
    }
  }

  Widget _getHomePage(bool isLogin) {
    return isLogin
        ? HomePage()
        : WelcomePage(
            title: 'Flutter Demo Home Page',
          );
  }
}
