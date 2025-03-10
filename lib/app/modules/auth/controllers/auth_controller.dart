import 'dart:async';
import 'package:yogo_pos/app/modules/onlineOrder/controllers/online_order_controller.dart';
import 'package:yogo_pos/app/services/base/preferences.dart';
import 'package:yogo_pos/app/services/controller/base_controller.dart';
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

  RxString password = "".obs;

  // **** Login *****

  void login() async {
    Map<String, dynamic> data = {"loginPin": int.parse(password.value)};
    // var token = Preferences.BRANCH_TOKEN;
    PopupDialog.showLoadingDialog();
    if (password.value.isNotEmpty) {
      // var res = await Dio().post(URLS.employeeLogin,
      //     data: data,
      //     options: Options(headers: {'BranchToken': 'Bearer $token'}));
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
      } else if (res.statusCode == 500) {
        PopupDialog.closeLoadingDialog();
        PopupDialog.showErrorMessage("Server Error");
      } else {
        PopupDialog.closeLoadingDialog();
        PopupDialog.showErrorMessage(res.data["message"]);
      }
      PopupDialog.closeLoadingDialog();
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
