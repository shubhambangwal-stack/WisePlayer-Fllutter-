import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';

Future<Map<String, String>> getDeviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    String macId = generateMacLikeId(
      androidId: androidInfo.id,
      model: androidInfo.model,
    );
    return {
      "brand": androidInfo.brand, // Samsung
      "model": androidInfo.model, // Galaxy S23
      "device": androidInfo.device, // s23
      "manufacturer": androidInfo.manufacturer, // samsung
      "androidVersion": androidInfo.version.release, // 14
      "sdkInt": androidInfo.version.sdkInt.toString(), // 34
      "androidId": androidInfo.id, // ANDROID_ID
      "macLikeId": macId,
    };
  }

  return {};
}

String generateMacLikeId({required String androidId, required String model}) {
  final raw = '$androidId|$model';

  final bytes = utf8.encode(raw);
  final digest = sha256.convert(bytes).toString();

  final mac = digest.substring(0, 12).toUpperCase();

  String macTypeAddress = mac
      .replaceAllMapped(RegExp(r'.{2}'), (match) => '${match.group(0)}:')
      .substring(0, 17);
  log("Your android id= $androidId and phone model is $model");
  log("Your mac type address is unique= $macTypeAddress");
  return macTypeAddress;
}
