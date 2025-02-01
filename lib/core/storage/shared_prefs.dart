import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _tokenKey = 'token';
  static const String _usernameKey = 'username';
  static const String _loginUsernameKey = 'loginUsername';
  static const String _loginUserPassKey = 'loginUserPass';
  static const String _userIdKey = 'userId';
  static const String _nameKey = 'name';
  static const String _emailKey = 'email';
  static const String _totalScoreKey = 'totalScore';
  static const String _badgesKey = 'badges';
  static const String _rolesKey = 'roles';

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save methods
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

  static Future<void> saveUserId(String userId) async {
    await _prefs.setString(_userIdKey, userId);
  }

  static Future<void> saveName(String name) async {
    await _prefs.setString(_nameKey, name);
  }

  static Future<void> saveEmail(String email) async {
    await _prefs.setString(_emailKey, email);
  }

  static Future<void> saveTotalScore(int totalScore) async {
    await _prefs.setInt(_totalScoreKey, totalScore);
  }

  static Future<void> saveBadges(List<String> badges) async {
    await _prefs.setStringList(_badgesKey, badges);
  }

  static Future<void> saveRoles(List<String> roles) async {
    await _prefs.setStringList(_rolesKey, roles);
  }

  // Get methods
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

  static Future<String?> getUserId() async {
    return _prefs.getString(_userIdKey);
  }

  static Future<String?> getName() async {
    return _prefs.getString(_nameKey);
  }

  static Future<String?> getEmail() async {
    return _prefs.getString(_emailKey);
  }

  static Future<int?> getTotalScore() async {
    return _prefs.getInt(_totalScoreKey);
  }

  static Future<List<String>?> getBadges() async {
    return _prefs.getStringList(_badgesKey);
  }

  static Future<List<String>?> getRoles() async {
    return _prefs.getStringList(_rolesKey);
  }

  // Clear all user data
  static Future<void> clearUserData() async {
    await _prefs.clear();
  }

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    return getToken() != null;
  }
}