// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preferences;

  static const String KEY_IS_FIRST_TIME = 'is_first_time';
  static const String ACCESS_TOKEN = 'access_token';
  static const String BRANCH_TOKEN = 'BranchToken';
  static const String CLOCK_IN_ID = 'Clock_in_id';
  static const String IS_USER_SIGNIN = 'is_user_signin';
  static const String KEY_IS_ACTIVER_EXPERT = 'is_active_Expert';
  static const String KEY_IS_LIGHT = 'is_light';
  static const String COUNTER_PRINTER = 'counter_printer';
  static const String KITCHEN_PRINTER = 'kitchen_printer';
  static const String BAR_PRINTER = 'bar_printer';
  static const String WING_SCALE = 'wing_scale';
  static const String USER_INFO = 'user_info';
  static const String MY_TIME_ZONE = 'my_time_zone';
  static const String RESTAURANT_DETAILS = "restaurant_details";
  static const String CASH_DRAWER_PORT = "cash_drawer_port";
  static const String BASE_URL = "base_url";
  // caller port
  static const String CALLER_PORT_1 = "caller_port_1";
  static const String CALLER_PORT_2 = "caller_port_2";
  // for Telephone Line
  static const String TELEPHONE_L1 = "telephone_l1";
  static const String TELEPHONE_L2 = "telephone_l2";
  //  Paper Width
  static const String PAPER_WIDTH = "paper_width";
  // print allow olo print
  static const String OLO_PRINT = "olo_print";
   // ======  Notification Sound ==========
  static const String NOTIFICATION_SOUND = "notification_sound";
   // ======  Custom Keyboard ==========
  static const String CUSTOM_KEYBOARD = "custom_keyboard"; 
  static const String KEYBOARD_SOUND = "keyboard_sound";
 



  ///  ====== init pref ============
  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  /// is user signin
  static bool get isUserSignin => preferences.getBool(IS_USER_SIGNIN) ?? false;
  static set isUserSignin(bool value) =>
      preferences.setBool(IS_USER_SIGNIN, value);

  /// isFirstTime
  static bool get isFirstTime => preferences.getBool(KEY_IS_FIRST_TIME) ?? true;
  static set isFirstTime(bool value) =>
      preferences.setBool(KEY_IS_FIRST_TIME, value);

  /// ACCESS_TOKEN
  static String get accessToken => preferences.getString(ACCESS_TOKEN) ?? '';
  static set accessToken(String value) =>
      preferences.setString(ACCESS_TOKEN, value);

  /// BRANCH_TOKEN
  static String get branchToken => preferences.getString(BRANCH_TOKEN) ?? '';
  static set branchToken(String value) =>
      preferences.setString(BRANCH_TOKEN, value);

  /// Selected Printers
  static String get counterPrinter =>
      preferences.getString(COUNTER_PRINTER) ?? '';
  static set counterPrinter(String? value) =>
      preferences.setString(COUNTER_PRINTER, value ?? '');

  static String get kitchenPrinter =>
      preferences.getString(KITCHEN_PRINTER) ?? '';
  static set kitchenPrinter(String? value) =>
      preferences.setString(KITCHEN_PRINTER, value ?? '');

  static String get barPrinter => preferences.getString(BAR_PRINTER) ?? '';
  static set barPrinter(String? value) =>
      preferences.setString(BAR_PRINTER, value ?? '');

  // Wingscale
  static String get wingScale => preferences.getString(WING_SCALE) ?? '';
  static set wingScale(String? value) =>
      preferences.setString(WING_SCALE, value ?? '');
  // time zone
  static String get myTimeZone =>
      preferences.getString(MY_TIME_ZONE) ?? 'America/Belize';
  static set myTimeZone(String? value) =>
      preferences.setString(MY_TIME_ZONE, value ?? 'America/Belize');

  /// CLOCK_IN_ID
  static String get clockInId => preferences.getString(CLOCK_IN_ID) ?? '';
  static set clockInId(String value) =>
      preferences.setString(CLOCK_IN_ID, value);

  /// Cash drader port
  static String get cashDrawerPort =>
      preferences.getString(CASH_DRAWER_PORT) ?? '';
  static set cashDrawerPort(String value) =>
      preferences.setString(CASH_DRAWER_PORT, value);

  /// is light theme
  static bool get isLight =>
      preferences.getBool(KEY_IS_LIGHT) ?? ThemeMode.system == ThemeMode.light;
  static set isLight(bool value) => preferences.setBool(KEY_IS_LIGHT, value);

  /// olo print
  static bool get isOloPrint => preferences.getBool(OLO_PRINT) ?? false;
  static set isOloPrint(bool value) => preferences.setBool(OLO_PRINT, value);
  //notification sound
  static bool get isNotificationSound => preferences.getBool(NOTIFICATION_SOUND) ?? false;
  static set isNotificationSound(bool value) => preferences.setBool(NOTIFICATION_SOUND, value);

  /// user info
  static String get user => preferences.getString(USER_INFO) ?? '';
  static set user(String value) => preferences.setString(USER_INFO, value);

  ///  Restaurant Details
  static String get restaurantDetails =>
      preferences.getString(RESTAURANT_DETAILS) ?? '';
  static set restaurantDetails(String value) =>
      preferences.setString(RESTAURANT_DETAILS, value);

  ///  base url
  static String get baseURL => preferences.getString(BASE_URL) ?? '';
  static set baseURL(String value) => preferences.setString(BASE_URL, value);

  ///  ***** caller Port ******
  // L1
  static String get callerPortL1 => preferences.getString(CALLER_PORT_1) ?? '';
  static set callerPortL1(String value) =>
      preferences.setString(CALLER_PORT_1, value);
  // L2
  static String get callerPortL2 => preferences.getString(CALLER_PORT_2) ?? '';
  static set callerPortL2(String value) =>
      preferences.setString(CALLER_PORT_2, value);
  // **** Telephone ****
  //l1
  static bool get telephoneL1 => preferences.getBool(TELEPHONE_L1) ?? false;
  static set telephoneL1(bool value) =>
      preferences.setBool(TELEPHONE_L1, value);
  //l2
  static bool get telephoneL2 => preferences.getBool(TELEPHONE_L2) ?? false;
  static set telephoneL2(bool value) =>
      preferences.setBool(TELEPHONE_L2, value);
  //Paper Width
  static String get paperWidth => preferences.getString(PAPER_WIDTH) ?? "80mm";
  static set paperWidth(String value) =>
      preferences.setString(PAPER_WIDTH, value);
  // **** remove *****
  static Future removeItem(String key) async {
    await preferences.remove(key);
  }
  // ***** Custom Keyboard *****
  static bool get customKeyboard => preferences.getBool(CUSTOM_KEYBOARD) ?? false;
  static set customKeyboard(bool value) => preferences.setBool(CUSTOM_KEYBOARD, value);
  // ***** Keyboard Sound *****
  static bool get keyboardSound => preferences.getBool(KEYBOARD_SOUND) ?? false;
  static set keyboardSound(bool value) => preferences.setBool(KEYBOARD_SOUND, value);
  
  // ***** Clear the SharedPreferences *****
  static void clear() {
    preferences.clear();
  }
}
