class Strings {
  static const String titleHome = 'title_home';
  static const String jumpCount = 'jump_count';
  static const String exitApp = 'exit_app';
  static const String titleLanguage = 'title_language';
  static const String titleSetting = 'title_setting';

  static const String languageAuto = 'language_auto';
  static const String languageZH = 'language_zh';
  static const String languageTW = 'language_tw';
  static const String languageHK = 'language_hk';
  static const String languageEN = 'language_en';
}

Map<String, Map<String, String>> localizedSimpleValues = {
  'en': {
    Strings.titleHome: 'Home',
    Strings.exitApp: 'exit_app',
    Strings.titleSetting: 'Setting',
    Strings.titleLanguage: 'Language',
  },
  'zh': {
    Strings.titleHome: '主页',
    Strings.exitApp: '再点一次退出应用!',
    Strings.titleSetting: '设置',
    Strings.titleLanguage: '切换语言'
  },
};

Map<String, Map<String, Map<String, String>>> localizedValues = {
  'zh': {
    'CN': {
      Strings.titleHome: '主页',
      Strings.jumpCount: '跳过 %\$0\$s',
      Strings.exitApp: '再点一次退出应用!',
      Strings.titleSetting: '设置',
      Strings.titleLanguage: '切换语言',
      Strings.languageAuto: '跟随系统',
      Strings.languageZH: '简体中文',
      Strings.languageTW: '繁體中文（台灣）',
      Strings.languageHK: '繁體中文（香港）',
      Strings.languageEN: 'English',
    },
    "TW": {
      Strings.titleHome: '主頁',
      Strings.jumpCount: '跳過 %\$0\$s',
      Strings.exitApp: '再点一次退出应用!',
      Strings.titleSetting: '设置',
      Strings.titleLanguage: '切換語言',
      Strings.languageAuto: '跟隨系統',
      Strings.languageZH: '简体中文',
      Strings.languageTW: '繁體中文（台灣）',
      Strings.languageHK: '繁體中文（香港）',
      Strings.languageEN: 'English',
    },
    "HK": {
      Strings.titleHome: '主頁',
      Strings.jumpCount: '跳過 %\$0\$s',
      Strings.exitApp: '再点一次退出应用!',
      Strings.titleSetting: '设置',
      Strings.titleLanguage: '切換語言',
      Strings.languageAuto: '跟隨系統',
      Strings.languageZH: '简体中文',
      Strings.languageTW: '繁體中文（台灣）',
      Strings.languageHK: '繁體中文（香港）',
      Strings.languageEN: 'English',
    }
  },
  'en': {
    'US': {
      Strings.titleHome: 'Home',
      Strings.jumpCount: 'Jump %\$0\$s',
      Strings.exitApp: '再点一次退出应用!',
      Strings.titleSetting: '设置',
      Strings.titleLanguage: 'Language',
      Strings.languageAuto: 'Auto',
    }
  }
};
