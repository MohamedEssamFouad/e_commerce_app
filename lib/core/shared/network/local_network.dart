import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork{
  static late SharedPreferences sharedPref;
  static Future cachInitlization()async{
    sharedPref=await SharedPreferences.getInstance();
  }

  static Future<bool> InsertToCache({required String key,required String value})async{
    return  await  sharedPref.setString(key, value);

  }
  static String getCachedData({required String key}){
    return sharedPref.getString(key)??"";
  }
  static Future<bool> DeletCItem({required String key})async{
    return await sharedPref.remove(key);
  }
}