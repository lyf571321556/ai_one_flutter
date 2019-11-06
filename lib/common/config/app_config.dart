class Config {
  static bool runInWeb = false;
  static const PAGE_SIZE = 20;
  static const RELEASE = const bool.fromEnvironment("dart.vm.product");
  static const TOKEN_KEY = "token";
  static const USER_NAME_KEY = "user-name";
  static const PW_KEY = "user-pw";
  static const USER_BASIC_CODE = "user-basic-code";
  static const USER_INFO = "user-info";
  static const LANGUAGE_SELECT = "language-select";
  static const LANGUAGE_SELECT_NAME = "language-select-name";
  static const REFRESH_LANGUAGE = "refreshLanguageApp";
  static const THEME_COLOR = "theme-color";
  static const LOCALE = "app_locale";

  static const LOGIN_HERO_TAG = "loginOpenHero";

  static const PROJECT_UUID = "";
  static OnesPlatform onesPlatform = OnesPlatform.iOS;
}

enum OnesPlatform {
  iOS,
  Android,
}
