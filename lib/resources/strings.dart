class Strings {
  static const String titleHome = 'title_home';
  static const String jumpCount = 'jump_count';
  static const String exitApp = 'exit_app';
  static const String titleLanguage = 'title_language';
  static const String changeLanguage = 'change_language';
  static const String titleTheme = 'title_theme';
  static const String changeTheme = 'change_theme';
  static const String titleSetting = 'title_setting';
  static const String titleLogin = 'title_login';
  static const String titleAccount = 'title_account';
  static const String titleAccountHint = 'title_account_hint';
  static const String titleAccountError = 'title_account_error';
  static const String titlePassword = 'title_password';
  static const String titlePasswordHint = 'title_password_hint';
  static const String titlePasswordError = 'title_password_error';

  static const String titleForgetPassword = 'title_forget_password';

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
      Strings.titleLanguage: '语言',
      Strings.changeLanguage: "切换语言",
      Strings.titleTheme: '主题',
      Strings.changeTheme: "切换主题",
      Strings.languageAuto: '跟随系统',
      Strings.languageZH: '简体中文',
      Strings.languageTW: '繁體中文（台灣）',
      Strings.languageHK: '繁體中文（香港）',
      Strings.languageEN: 'English',
      Strings.titleLogin: '登录',
      Strings.titleAccount: '账号',
      Strings.titleAccountHint: "请输入账号",
      Strings.titleAccountError: "请输入正确的账号",
      Strings.titlePassword: '密码',
      Strings.titlePasswordHint: "请输入密码",
      Strings.titlePasswordError: "密码为8~32位,且必须包含大小写字母和数字",
      Strings.titleForgetPassword: "忘记密码?",
    },
    "TW": {
      Strings.titleHome: '主頁',
      Strings.jumpCount: '跳過 %\$0\$s',
      Strings.exitApp: '再点一次退出应用!',
      Strings.titleSetting: '设置',
      Strings.titleLanguage: '語言',
      Strings.changeLanguage: "切換語言",
      Strings.titleTheme: '主題',
      Strings.changeTheme: "切换主題",
      Strings.languageAuto: '跟隨系統',
      Strings.languageZH: '简体中文',
      Strings.languageTW: '繁體中文（台灣）',
      Strings.languageHK: '繁體中文（香港）',
      Strings.languageEN: 'English',
      Strings.titleLogin: '登 錄',
      Strings.titleAccount: '賬號',
      Strings.titleAccountHint: "請輸入賬號",
      Strings.titleAccountError: "請輸入正確的賬號",
      Strings.titlePassword: '密碼',
      Strings.titlePasswordHint: "请输入密碼",
      Strings.titlePasswordError: "密碼8~32位,且必須包含大小寫字母和數字",
      Strings.titleForgetPassword: "忘記密碼?",
    },
    "HK": {
      Strings.titleHome: '主頁',
      Strings.jumpCount: '跳過 %\$0\$s',
      Strings.exitApp: '再点一次退出应用!',
      Strings.titleSetting: '设置',
      Strings.titleLanguage: '語言',
      Strings.changeLanguage: "切換語言",
      Strings.titleTheme: '主題',
      Strings.changeTheme: "切换主題",
      Strings.languageAuto: '跟隨系統',
      Strings.languageZH: '简体中文',
      Strings.languageTW: '繁體中文（台灣）',
      Strings.languageHK: '繁體中文（香港）',
      Strings.languageEN: 'English',
      Strings.titleLogin: '登 錄',
      Strings.titleAccount: '賬號',
      Strings.titleAccountHint: "請輸入賬號",
      Strings.titleAccountError: "請輸入正確的賬號",
      Strings.titlePassword: '密碼',
      Strings.titlePasswordHint: "请输入密碼",
      Strings.titlePasswordError: "密碼8~32位,且必須包含大小寫字母和數字",
      Strings.titleForgetPassword: "忘記密碼?",
    }
  },
  'en': {
    'US': {
      Strings.titleHome: 'Home',
      Strings.jumpCount: 'Jump %\$0\$s',
      Strings.exitApp: '再点一次退出应用!',
      Strings.titleSetting: '设置',
      Strings.titleLanguage: 'Language',
      Strings.changeLanguage: "Switch Language",
      Strings.titleTheme: 'Theme',
      Strings.changeTheme: "Switch Theme",
      Strings.languageAuto: 'Auto',
      Strings.titleLogin: 'Login',
      Strings.titleAccount: 'Account',
      Strings.titleAccountHint: 'Input account',
      Strings.titleAccountError: "Wrong account",
      Strings.titlePassword: 'Password',
      Strings.titleAccount: 'Account',
      Strings.titlePasswordHint: 'Input password',
      Strings.titlePasswordError: "",
      Strings.titleForgetPassword: "Forget password?",
    }
  }
};
