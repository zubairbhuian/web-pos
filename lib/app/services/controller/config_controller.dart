import 'package:flutter/material.dart';
import 'package:yogo_pos/app/services/base/preferences.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController {
  static ConfigController get to => Get.find();

  bool isLightTheme = Preferences.isLight;

  void toggleTheme() {
    isLightTheme = !isLightTheme;
    Preferences.isLight = isLightTheme;
    // kLogger.e(Preferences.isLight);
    Get.changeThemeMode(isLightTheme ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  void onInit() {
    isLightTheme = Preferences.isLight;

    super.onInit();
  }
}
