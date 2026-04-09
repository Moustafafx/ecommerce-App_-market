
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCache {
 static late SharedPreferences Shared_Preferences;

 static Future<void> cacheInitialization() async {
    Shared_Preferences = await SharedPreferences.getInstance();
  }




static  Future<bool> setdata({required String key, required dynamic value})async {
    if (value is bool) {
     await Shared_Preferences.setBool(key, value);
      return true;
    }
    if (value is String) {
     await Shared_Preferences.setString(key, value);
      return true;

    }
    if (value is double) {
    await  Shared_Preferences.setDouble(key, value);
      return true;

    }
    if(value is int){
    await    Shared_Preferences.setInt(key, value);
      return true; 

    }
          return false;

  }


static dynamic getdata({required String key }){

 return Shared_Preferences.get(key);
  
}



static Future<bool> deletedata({required String key}) async {

await Shared_Preferences.remove(key);
 return true;
}




}
