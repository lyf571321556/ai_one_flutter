import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:auto_size/auto_size.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/widget/locale/LocalizationWidget.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/ui/pages/welcome_page.dart';
import 'package:ones_ai_flutter/ui/pages/home_page.dart';
import 'package:ones_ai_flutter/utils/navigator_utils.dart';


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
      initialState: new OnesGlobalState(locale: Locale("zh", "CH"),themeData:ThemeData.light().copyWith(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.blueAccent,
        indicatorColor: Colors.white,
      ),platformLocale: WidgetsBinding.instance.window.locale));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print( onesStore.state.platformLocale );
    setLocalizedValues(localizedValues);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<OnesGlobalState>(
        store: onesStore,
        child: StoreBuilder<OnesGlobalState>(builder: (context, store) {
          return MaterialApp(
            title: 'Ones App',
            onGenerateTitle: (BuildContext context) {
              return IntlUtil.getString(context, Strings.titleHome);
            },
            locale: store.state.locale,
            supportedLocales: CustomLocalizations.supportedLocales,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              CustomLocalizations.delegate
            ],
            theme: store.state.themeData,
            routes:{
              HomePage.pageName:(context){
                return new LocalizationsWidget(child: NavigatorUtils.pageContainer(new HomePage()),);
              }
            },
            home: WelcomePage(title: 'Flutter Demo Home Page'),
          );
        }));
  }
}


