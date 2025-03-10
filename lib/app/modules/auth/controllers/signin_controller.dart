import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yogo_pos/app/routes/app_pages.dart';
import 'package:yogo_pos/app/services/base/base_model.dart';
import 'package:yogo_pos/app/services/base/preferences.dart';
import 'package:yogo_pos/app/services/controller/base_controller.dart';
import 'package:yogo_pos/app/utils/logger.dart';
import 'package:yogo_pos/app/utils/urls.dart';
import 'package:yogo_pos/app/widgets/popup_dialogs.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final FocusNode passFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  TextEditingController emailControlller = TextEditingController();
  TextEditingController passwordControlller = TextEditingController();

  RxBool isEmailPage = true.obs;
  RxBool isPassHide = true.obs;

  // **** Login *****
  void signInWithEmail() async {
    Map<String, dynamic> data = {
      "email": emailControlller.text.toLowerCase().trim(),
      "password": passwordControlller.text.trim(),
    };
    PopupDialog.showLoadingDialog();
    BaseModel res =
        await BaseController.to.apiService.makePostRequest(URLS.login, data);
    PopupDialog.closeLoadingDialog();
    if (res.statusCode == 200 || res.statusCode == 201) {
      Get.offAllNamed(Routes.AUTH);
      // set restaurant details
      await BaseController.to.setRestaurantDetails(res.data["data"]["user"]);
      kLogger.e(BaseController
          .to.restaurantDetails?.restaurant.packagingCostModel.cost);
      kLogger.e(BaseController
          .to.restaurantDetails?.restaurant.packagingCostModel.title);
      // set token
      Preferences.branchToken = res.data["data"]["accessToken"];
      // set time zone
      Preferences.myTimeZone =
          res.data["data"]["user"]["businessProfile"]["timeZone"];
    } else {
      // if (res.statusCode == 404 || res.statusCode == 406)
      PopupDialog.showErrorMessage(res.data["message"]);
    }
  }

  @override
  void onClose() {
    emailFocusNode.dispose();
    passFocusNode.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    if (kDebugMode) {
      emailControlller.text = "admin@yogopos.com";
      passwordControlller.text = "30735624";
    }
    super.onReady();
  }
}
