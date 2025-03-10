import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yogo_pos/app/modules/setting/models/settings_menu_model.dart';
import 'package:yogo_pos/app/modules/setting/views/pages/general.dart';
import 'package:yogo_pos/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find();
  int menuIndex = 0;
  List<SettingsMenuModel> menuList = [
    // SettingsMenuModel(
    //     child: const Payments(), icon: Icons.payment, title: "Payments"),
    SettingsMenuModel(
        child: const General(), icon: Icons.settings, title: "General"),
    // SettingsMenuModel(
    //     child: const About(), icon: Icons.info_rounded, title: "About"),
  ];
  // change menu
  onChangeMenu(int index) {
    menuIndex = index;
    update();
  }

  void restartApp() {
    if (!kDebugMode) {
      try {
        // Get the current executable's path
        final executable = Platform.resolvedExecutable;
        final arguments = Platform.executableArguments;

        // Relaunch the app
        Process.start(executable, arguments).then((_) {
          // Close the current instance
          exit(0);
        });
      } catch (e) {
        PopupDialog.showErrorMessage('Error while restarting app: $e');
      }
    }
  }

  void closeApp() {
    exit(0); // Closes the app immediately.
  }
}
