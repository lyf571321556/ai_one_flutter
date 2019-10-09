import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/models/system/model_language.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';
import 'package:redux/redux.dart';

class LanguageSelectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LanguageSelectPageState();
  }
}

class _LanguageSelectPageState extends State<LanguageSelectPage> {
  List<LanguageModel> _Languagelist = new List();

  @override
  Future initState() {
    // TODO: implement initState
    super.initState();
    _Languagelist.add(LanguageModel(Strings.languageAuto, '', ''));
    _Languagelist.add(LanguageModel(Strings.languageZH, 'zh', 'CH'));
    _Languagelist.add(LanguageModel(Strings.languageTW, 'zh', 'TW'));
    _Languagelist.add(LanguageModel(Strings.languageHK, 'zh', 'HK'));
    _Languagelist.add(LanguageModel(Strings.languageEN, 'en', 'US'));
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    Store<OnesGlobalState> store = StoreProvider.of(context);
//    store.state.platformLocale = WidgetsBinding.instance.window.locale;
//    print(store.state.platformLocale);
  }

  void _changeLauguage(
      LanguageModel languageModel, Store<OnesGlobalState> store) {
    setState(() {});
    if (languageModel.titleId == Strings.languageAuto) {
      CommonUtils.changeLocale(store, null);
      LocalStorage.put(Config.LOCALE, "");
    } else {
      CommonUtils.changeLocale(
          store, Locale(languageModel.languageCode, languageModel.countryCode));
      LocalStorage.put(Config.LOCALE,
          languageModel.languageCode + "-" + languageModel.countryCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(child: StoreBuilder<OnesGlobalState>(
      builder: (context, store) {
        return Scaffold(
          appBar: new AppBar(
              title: new Text(
            IntlUtil.getString(context, Strings.titleLanguage),
            style: new TextStyle(fontSize: 16.0),
          )),
          body: ListView.builder(
            itemBuilder: (context, index) {
              LanguageModel languageModel = _Languagelist[index];
              String title = languageModel.titleId == Strings.languageAuto
                  ? IntlUtil.getString(context, languageModel.titleId)
                  : IntlUtil.getString(context, languageModel.titleId,
                      languageCode: 'zh', countryCode: 'CH');
              bool isSelected = (store.state.locale != null &&
                  store.state.locale.countryCode == languageModel.countryCode &&
                  store.state.locale.languageCode ==
                      languageModel.languageCode);
              print("5-" + store.state.platformLocale.toString());
              print("6-" + store.state.locale.toString());
              if (languageModel.titleId == Strings.languageAuto) {
                isSelected = store.state.locale == null;
              }
              return ListTile(
                title: Text(
                  title,
                  style: new TextStyle(fontSize: 13.0),
                ),
                trailing: new Radio(
                    value: true,
                    groupValue: isSelected,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      _changeLauguage(languageModel, store);
                    }),
                onTap: () {
                  _changeLauguage(languageModel, store);
                },
              );
            },
            itemCount: _Languagelist.length,
          ),
        );
      },
    ));
  }
}
