import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const childNameKey = 'child_name';
  static const parentEmailKey = 'parent_email';
  Future<SharedPreferences> get sharedPrefs => SharedPreferences.getInstance();

  Future<void> saveChildName(String name) async {
    final prefs = await sharedPrefs;
    await prefs.setString(childNameKey, name);
  }

  Future<void> saveParentEmail(String email) async {
    final prefs = await sharedPrefs;
    await prefs.setString(parentEmailKey, email);
  }

  Future<String?> getChildName() async {
    final prefs = await sharedPrefs;
    return prefs.getString(childNameKey);
  }

  Future<String?> getParentEmail() async {
    final prefs = await sharedPrefs;
    return prefs.getString(parentEmailKey);
  }

  Future<void> clearData() async {
    final prefs = await sharedPrefs;
    await prefs.remove(childNameKey);
    await prefs.remove(parentEmailKey);
  }
}
