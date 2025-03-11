import 'dart:async';
import 'package:yogo_pos/app/modules/onlineOrder/controllers/online_order_controller.dart';
import 'package:yogo_pos/app/routes/app_pages.dart';
import 'package:yogo_pos/app/services/base/preferences.dart';
import 'package:yogo_pos/app/services/controller/base_controller.dart';
import 'package:yogo_pos/app/utils/logger.dart';
import 'package:yogo_pos/app/utils/urls.dart';
import 'package:yogo_pos/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  //splash screen
  RxBool isShowSplashScreen = true.obs;
  void hideSplashScreen() {
    Timer(const Duration(milliseconds: 2500), () {
      isShowSplashScreen.value = false;
    });
  }

  RxString password = "2332".obs;

  // **** Login *****

  void login() async {
    print("login");
    Map<String, dynamic> data = {"loginPin": int.parse(password.value)};
    // var token = Preferences.BRANCH_TOKEN;

    if (password.value.isNotEmpty) {
      // var res = await Dio().post(URLS.employeeLogin,
      //     data: data,
      //     options: Options(headers: {'BranchToken': 'Bearer $token'}));
      try {
        PopupDialog.showLoadingDialog();
        var res = await BaseController.to.apiService
            .makePostRequest(URLS.employeeLogin, data);
        if (res.statusCode == 200 || res.statusCode == 201) {
          // save the access token
          Preferences.accessToken = res.data["data"]["accessToken"];

          await BaseController.to.setEmployeeData(res.data["data"]["employee"]);
          Get.lazyPut<OnlineOrderController>(
            () => OnlineOrderController(),
          );
          
          await OnlineOrderController.to.getOrders();
          PopupDialog.closeLoadingDialog();
          Get.offAllNamed(Routes.OLO);
        } else if (res.statusCode == 500) {
          PopupDialog.closeLoadingDialog();
          PopupDialog.showErrorMessage("Server Error");
        } else {
          PopupDialog.closeLoadingDialog();
          PopupDialog.showErrorMessage(res.data["message"]);
        }
      } catch (e) {
        kLogger.e('Error from %%%% login %%%% => $e');
        PopupDialog.closeLoadingDialog();
      }
    }
  }

  removePassword() {
    if (password.value.isNotEmpty) {
      password.value = password.value.substring(0, password.value.length - 1);
    }
  }

  addPassword(String characterToAdd) {
    if (password.value.length < 6) {
      password.value += characterToAdd;
      // kLogger.e(password.value);
    }
  }

  @override
  void onInit() {
    hideSplashScreen();
    super.onInit();
  }
}
