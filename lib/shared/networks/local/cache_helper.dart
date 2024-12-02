
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/login_model.dart';

class CacheHelper {
  static late SharedPreferences sharedPreference;

  static init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}){
    return sharedPreference.get(key);
  }

  static Future<bool?> saveData({
    required String key,
    required dynamic value,
}) async{
    if(value is String) return await sharedPreference.setString(key, value);
    if(value is int) return await sharedPreference.setInt(key, value);
    if(value is bool) return await sharedPreference.setBool(key, value);

    return await sharedPreference.setDouble(key, value);
  }

  static Future<bool> removeData({required String key})async{
    return await sharedPreference.remove(key);
}
  static Future<void> saveUserData(LoginModel? user) async {
    final prefs = await SharedPreferences.getInstance();
    String userData = jsonEncode(user!.toJson()); // Convert to JSON
    await prefs.setString('user_data', userData);
  }

  static Future<LoginModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData); // Deserialize JSON
      return LoginModel.fromJson(userMap);
    }
    return null;
  }

 static Future<void> updateUserData({String? name, String? email, String? phone}) async {
    // Step 1: Retrieve the current LoginModel from SharedPreferences
    LoginModel? currentUser = await getUserData();

    if (currentUser != null) {
      // Step 2: Update the fields if new values are provided
      currentUser.data?.name = name ?? currentUser.data?.name;
      currentUser.data?.email = email ?? currentUser.data?.email;
      currentUser.data?.phone = phone ?? currentUser.data?.phone;

      // Step 3: Save the updated model back to SharedPreferences
      await saveUserData(currentUser);
    }
  }


}
