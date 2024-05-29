import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  SharedPrefUtils._();

  static SharedPreferences? _instance;

  static Future<SharedPreferences?> getInstance() async {
    debugPrint("SharedPrefUtils getInstance() called");
    _instance ??= await SharedPreferences.getInstance();
    return _instance;
  }
}
