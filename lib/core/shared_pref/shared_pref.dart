import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<String?> setUserDeviceInfo({
    required String macAddress,
    required String deviceId,
    required String status,
    required String token,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('deviceId', deviceId);
    pref.setString('mac', macAddress);
    pref.setString('status', status);
    pref.setString('token', token); //INACTIVE
  }

  static Future<Map<String, dynamic>> getUserDeviceInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, String> userinfo = {
      'deviceId': pref.getString('deviceId') ?? '',
      'mac': pref.getString('mac') ?? '',
      'status': pref.getString('status') ?? '',
      'token': pref.getString('token') ?? '', //INACTIVE
    };
    return userinfo;
  }

  static Future<bool> getUserDeviceStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String status = pref.getString('status') ?? "";
    if (status == "INACTIVE" || status.isEmpty || status == "") {
      return false;
    } else {
      return true;
    }
  }

  static setUserDeviceStatus(String status) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('status', status.toUpperCase());
  }

  static setValidateStatus({
    required String deviceId,
    required String status,
    required String token,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('deviceId', deviceId);
    pref.setString('status', status);
    pref.setString('token', token);
  }
}
