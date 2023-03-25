import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeController extends GetxController {
  // Variables
  bool isDarkMode = Hive.box('locals').get("isDarkMode") ?? false;
  String logoBasedOnTheme = 'assets/docs_assets/Logo_light_mode.png';

  // get it from box
  ThemeMode getPreviousTheme() {
    if (isDarkMode) {
      logoBasedOnTheme = 'assets/docs_assets/Logo_dark_mode.png';
      return ThemeMode.dark;
    }
    logoBasedOnTheme = 'assets/docs_assets/Logo_light_mode.png';
    return ThemeMode.light;
  }

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    if (isDarkMode) {
      logoBasedOnTheme = 'assets/docs_assets/Logo_dark_mode.png';

      Get.changeThemeMode(ThemeMode.dark);
    } else {
      logoBasedOnTheme = 'assets/docs_assets/Logo_light_mode.png';
      Get.changeThemeMode(ThemeMode.light);
    }
    // Set new bool to box
    Hive.box('locals').put("isDarkMode", isDarkMode);
    update();
  }
}
