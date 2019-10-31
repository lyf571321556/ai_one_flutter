import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';

class LocalDataHelper {
  static final LocalStorage localStorage = new LocalStorage("ones-app-data");

  static put(String key, value) async {
//    await localStorage.setItem(key, value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
//    return localStorage.getItem(key);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
//    await localStorage.deleteItem(key);
  }
}
