import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _tokenKey = 'token';
  static const String _usernameKey = 'username';
  static const String _loginUsernameKey = 'loginUsername';
  static const String _loginUserPassKey = 'loginUserPass';

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  static Future<void> saveLoginUserName(String userName) async {
    await _prefs.setString(_loginUsernameKey, userName);
  }

  static Future<void> saveLoginUserPass(String password) async {
    await _prefs.setString(_loginUserPassKey, password);
  }

  static Future<void> saveUsername(String username) async {
    await _prefs.setString(_usernameKey, username);
  }

  static Future<String?> getToken() async {
    return _prefs.getString(_tokenKey);
  }

  static Future<String?> getLoginUserName() async {
    return _prefs.getString(_loginUsernameKey);
  }

  static Future<String?> getLoginUserPass() async {
    return _prefs.getString(_loginUserPassKey);
  }

  static Future<String?> getUsername() async {
    return _prefs.getString(_usernameKey);
  }

  static Future<void> clearUserData() async {
    await _prefs.clear();
  }

  static Future<bool> isUserLoggedIn() async {
    return getToken() != null;
  }
}
