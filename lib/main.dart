import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ones_ai_flutter/common/dao/app_dao.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:auto_size/auto_size.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/widget/locale/LocalizationWidget.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/ui/pages/welcome_page.dart';
import 'package:ones_ai_flutter/ui/pages/home_page.dart';
import 'package:ones_ai_flutter/utils/navigator_utils.dart';

import 'common/redux/global/locale_redux.dart';

void main() {
  runZoned(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
      return Container(color: Colors.transparent);
    };
    runAutoSizeApp(OnesApp());
//    runApp(OnesApp());
    PaintingBinding.instance.imageCache.maximumSize = 100;
  }, onError: (object, stack) {
    print(object);
    print(stack);
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
  final Store onesStore = new Store<OnesGlobalState>(createOnesAppReducer,
      middleware: onesMiddlewares,
      initialState: new OnesGlobalState(
          locale: null,
          themeData: ThemeData.light().copyWith(
            primaryColor: Colors.blueAccent,
            accentColor: Colors.blueAccent,
            indicatorColor: Colors.white,
          ),
          platformLocale: WidgetsBinding.instance.window.locale));

  @override
  void initState() {
    // TODO: implement initState
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
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StoreProvider<OnesGlobalState>(
              store: snapshot.data,
              child: StoreBuilder<OnesGlobalState>(builder: (context, store) {
                return MaterialApp(
                  debugShowCheckedModeBanner:false,
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
                  localeListResolutionCallback: (List<Locale> locales,
                      Iterable<Locale> supportedLocales) {
                    print(store.state.locale);
                    if (locales.length <= 0 || store.state.locale != null) {
                      return;
                    }
                    print("=====");
                    if (localizedValues.containsKey(locales[0].languageCode)) {
                      if (store.state.platformLocale == null ||
                          locales[0].languageCode !=
                              store.state.platformLocale.languageCode ||
                          locales[0].countryCode !=
                              store.state.platformLocale.countryCode) {
                        store.state.platformLocale = locales[0];
//                        store.dispatch(ChangeLocaleAction(locales[0]));
                        store.dispatch(ChangePlatformLocaleAction(locales[0]));
                        print("0" + locales[0].toString());
                      }
                    } else {
                      print("00-" + supportedLocales.first.toString());
//                      store.dispatch(ChangeLocaleAction(supportedLocales.first));
                      store.dispatch(
                          ChangePlatformLocaleAction(supportedLocales.first));
                    }
                  },
                  theme: store.state.themeData,
                  routes: {
                    HomePage.pageName: (context) {
                      return new LocalizationsWidget(
                        child: NavigatorUtils.pageContainer(new HomePage()),
                      );
                    }
                  },
                  home: WelcomePage(title: 'Flutter Demo Home Page'),
                );
              }));
        } else {
          return Container();
        }
      },
      future: AppDao.initApp(onesStore),
    );
  }
}
