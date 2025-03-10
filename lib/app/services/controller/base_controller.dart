import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:yogo_pos/app/services/base/base_model.dart';
import 'package:yogo_pos/app/utils/logger.dart';
import 'package:get/get.dart';
import 'package:yogo_pos/app/utils/urls.dart';
import 'package:yogo_pos/app/widgets/popup_dialogs.dart';
import '../base/api_service.dart';
import '../base/preferences.dart';
import '../models/restaurant_details_model.dart';

class BaseController extends GetxController {
  static BaseController get to => Get.find();
  int clockInSeconds = 0;
  bool isSocketConnected = false;
  final ApiService apiService;
  BaseController({required this.apiService});
  RestaurantDetailsModel? restaurantDetails;

  Uint8List? printByteImgData;

  bool get isFirstTime => Preferences.isFirstTime;
  set isFirstTime(bool isFirstTime) => Preferences.isFirstTime = isFirstTime;
  bool get isLoggedIn => Preferences.accessToken.isNotEmpty;
  set token(String token) => Preferences.accessToken = token;

  //! +++++ Employee +++++
  setEmployeeData(Map<String, dynamic> userData) async {
    // Convert the Map to a JSON string
    String userDataJson = jsonEncode(userData);
    // Save the JSON string
    Preferences.user = userDataJson;
    // await saveEmployeeData();
    update();
  }

  // Future<EmployeeModel?> saveEmployeeData() async {
  //   // Get the JSON string
  //   String employeeJson = Preferences.user;

  //   if (employeeJson.isNotEmpty) {
  //     // Convert the JSON string back to an EmployeeModel
  //     Map<String, dynamic> employeeMap = jsonDecode(employeeJson);

  //     var employee = EmployeeModel.fromJson(employeeMap);
  //     employeeData = employee;
  //     return employee;
  //   }
  //   return null;
  // }

  //! +++++ Restaurant Details +++++
  setRestaurantDetails(Map<String, dynamic> userData) async {
    // Convert the Map to a JSON string
    String userDataJson = jsonEncode(userData);
    // Save the JSON string
    Preferences.restaurantDetails = userDataJson;
    await getRestaurantDetails();
    update();
  }

  Future<RestaurantDetailsModel?> getRestaurantDetails() async {
    // Get the JSON string
    String stringData = Preferences.restaurantDetails;

    if (stringData.isNotEmpty) {
      // Convert the JSON string back to an EmployeeModel
      Map<String, dynamic> restaurantDetailsAsMap = jsonDecode(stringData);

      var restaurant = RestaurantDetailsModel.fromJson(restaurantDetailsAsMap);
      restaurantDetails = restaurant;
      loadPrintImg(restaurant.restaurant.printLogo);
      return restaurant;
    }
    return null;
  }

  loadPrintImg(String base64String) {
    if (base64String.isNotEmpty) {
      // Remove the prefix if it exists
      if (base64String.startsWith('data:image/png;base64,')) {
        base64String = base64String.replaceFirst('data:image/png;base64,', '');
      }
      try {
        Uint8List bytes = base64Decode(base64String);
        printByteImgData = bytes;
      } catch (e) {
        kLogger.e("Base64 string convert issue :$e");
        printByteImgData == null;
      }
    } else {
      printByteImgData == null;
      kLogger.e("Base64 string is empty or null");
    }
  }

  Future<void> logout() async {
    await Preferences.removeItem(Preferences.KEY_IS_FIRST_TIME);
    await Preferences.removeItem(Preferences.ACCESS_TOKEN);
    await Preferences.removeItem(Preferences.BRANCH_TOKEN);
    await Preferences.removeItem(Preferences.CLOCK_IN_ID);
    await Preferences.removeItem(Preferences.IS_USER_SIGNIN);
    await Preferences.removeItem(Preferences.KEY_IS_ACTIVER_EXPERT);
    await Preferences.removeItem(Preferences.KEY_IS_LIGHT);
    // await Preferences.removeItem(Preferences.KITCHEN_PRINTER);
    // await Preferences.removeItem(Preferences.COUNTER_PRINTER);
    // await Preferences.removeItem(Preferences.BAR_PRINTER);
    await Preferences.removeItem(Preferences.WING_SCALE);
    await Preferences.removeItem(Preferences.USER_INFO);
    await Preferences.removeItem(Preferences.MY_TIME_ZONE);
    await Preferences.removeItem(Preferences.RESTAURANT_DETAILS);
    await Preferences.removeItem(Preferences.CASH_DRAWER_PORT);

    // Preferences.clear();
  }

  onChangeSocketConnection(bool value) {
    isSocketConnected = value;
    update();
  }

  void playTapSound() {
    // AudioPlayer().play(AssetSource('audio/tap_sound_1.mp3'));
  }
  void playNotificationSound() {
    AudioPlayer().play(AssetSource('audio/notification_4.mp3'));
  }

  void playKeybordSound() {
    AudioPlayer().play(AssetSource('audio/tap_sound_1.mp3'));
  }

  // for lock dialog
  Timer? inactivityTimer;
  bool isEntryView = false;
  int logOutTime = 5;

  void startInactivityTimer() {
    inactivityTimer?.cancel(); // Cancel any previous timer
    inactivityTimer =
        Timer(Duration(seconds: logOutTime), showInactivityDialog);
    // isEntryView = false;
  }

  void resetInactivityTimer() {
    startInactivityTimer();
  }

  resetOutoutTimer() {
    Timer.periodic(Duration(seconds: logOutTime - 1), (Timer timer) {
      startInactivityTimer();
      kLogger.i(DateTime.now());
    });
  }

  void showInactivityDialog() {
    // Get.toNamed(Routes.AUTH);
    // if (isEntryView) {
    //   showDialog<void>(
    //     // Context
    //     context: Get.context!,
    //     // barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return const LockDialog();
    //     },
    //   );
    // }
  }

  getRestaurantsDetailsFromAPI() async {
    BaseModel res = await BaseController.to.apiService
        .makeGetRequest(URLS.restaurantsDetails);
    if (res.statusCode == 200) {
      // set restaurant details
      await setRestaurantDetails(res.data["data"]);
      // set time zone
      Preferences.myTimeZone = res.data["data"]["businessProfile"]["timeZone"];
    } else {
      // if (res.statusCode == 404 || res.statusCode == 406)
      PopupDialog.showErrorMessage(res.data["message"]);
    }
  }

  @override
  void onInit() {
    getRestaurantDetails();
    // for lock dialog
    // startInactivityTimer();
    // if (isEntryView) {
    //   startInactivityTimer();
    // }
    super.onInit();
  }
}
