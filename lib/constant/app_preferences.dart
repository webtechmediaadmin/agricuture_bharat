import 'package:shared_preferences/shared_preferences.dart';

class PreferenceApp {

  setAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    return token;
  }

  setIsNewUser(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isNewUser", value);
  }

  Future<bool?> getIsNewUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool("isNewUser");
    return value;
  }

  removePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('isNewUser');
    // prefs.remove('isProfileUpdated');
    // prefs.remove('roleType');
    //  prefs.remove('level');
  }

}