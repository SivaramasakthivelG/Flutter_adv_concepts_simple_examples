

import 'package:flutter/services.dart';

class LinkingService {
  static const platform = MethodChannel('battery_channel');

  static Future<void> setMaxBrightness() async {
    await platform.invokeMethod('setMaxBrightness');
  }

  static Future<int> getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      return result;
    } catch (e) {
      return -1;
    }
  }

}