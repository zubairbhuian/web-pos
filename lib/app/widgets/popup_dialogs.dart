
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:yogo_pos/app/services/controller/base_controller.dart';
import 'package:yogo_pos/app/services/controller/config_controller.dart';
import 'package:yogo_pos/app/utils/logger.dart';
import 'package:yogo_pos/app/utils/static_colors.dart';
import 'package:yogo_pos/app/widgets/custom_btn.dart';
import 'package:yogo_pos/app/widgets/custom_textfield.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PopupDialog {
  // SuccessDialog
  static void showSuccessDialog(String message, {double? width}) {
    // ThemeData theme = Theme.of(Get.context!);
    // var snackBar = SnackBar(
    //     dismissDirection: DismissDirection.up,
    //     behavior: SnackBarBehavior.floating,
    //     width: width ?? 500,
    //     duration: const Duration(seconds: 3),
    //     backgroundColor: StaticColors.greenColor,
    //     content: Center(child: MyCustomText(message, color: Colors.white)));
    // ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    toastification.show(
      title: Text(
        message,
        maxLines: 3,
      ),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  // error messase
  static void showErrorMessage(String message, {double? width}) {
    // ThemeData theme = Theme.of(Get.context!);
    // var snackBar = SnackBar(
    //   width:width?? 500,
    //   behavior: SnackBarBehavior.floating,
    //   dismissDirection: DismissDirection.up,
    //   backgroundColor: Colors.redAccent,
    //   content: Center(
    //       child: MyCustomText(
    //     maxLines: 3,
    //     message,
    //     color: Colors.white,
    //     textAlign: TextAlign.center,
    //   )),
    //   duration: const Duration(seconds: 3),
    // );
    // ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    toastification.show(
      title: Text(
        message,
        maxLines: 3,
      ),
      type: ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
  // Loading Dialog

  static showLoadingDialog() {
    ThemeData theme = Theme.of(Get.context!);
    return showDialog<void>(
      // Context
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Column(
          // for horizontal minHeight
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // for ertical minWidth
            Center(
              child: SizedBox(
                // dialog width
                width: 120,
                height: 120,
                child: Material(
                  elevation: 2,
                  // dialog color
                  shadowColor: Colors.transparent,
                  // backgraund color
                  color: Colors.transparent,
                  // border radius
                  borderRadius: BorderRadius.circular(8),
                  // main body
                  /// DoubleBounce
                  /// SpinningLines
                  child: SpinKitRing(
                    color: theme.primaryColor,
                    size: 53, // You can customize the size
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static customDialog({
    required Widget child,
    double? width,
    double? height,
    Color? color,
    Color? iconColor,
    Widget topLavel = const SizedBox(),
    bool hasScroll = true,
    EdgeInsetsGeometry? padding,
  }) {
    return showDialog<void>(
      // Context
      context: Get.context!,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        ThemeData theme = Theme.of(context);
        return Center(
          child: SizedBox(
            height: height,
            width: width ?? MediaQuery.sizeOf(context).width * 0.7,
            child: Material(
              elevation: 3,
              // dialog color
              shadowColor: ConfigController.to.isLightTheme
                  ? Colors.black12
                  : Colors.white,
              // backgraund color
              color: color ??
                  (ConfigController.to.isLightTheme
                      ? theme.canvasColor
                      : StaticColors.cartColor),
              // border radius
              borderRadius: BorderRadius.circular(6),

              /// SpinningLines
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 0, top: 0, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        topLavel,
                        InkWell(
                          onTap: Get.back,
                          splashFactory: NoSplash.splashFactory,
                          child: Icon(
                            Icons.close,
                            color: iconColor ??
                                Theme.of(context).colorScheme.surface,
                            size: 38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: hasScroll
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: padding ??
                                  const EdgeInsets.only(
                                      left: 20, right: 26, bottom: 20),
                              child: child,
                            ),
                          )
                        : Padding(
                            padding: padding ??
                                const EdgeInsets.only(
                                    left: 20, right: 26, bottom: 20),
                            child: child,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static permissionDialog(ThemeData theme,
      {required void Function() onSubmit,
      void Function()? onCancle,
      TextStyle? titleStyle,
      required String title}) {
    customDialog(
        width: 500,
        child: Column(
          children: [
            //title
            Text(
              title,
              style: titleStyle ?? theme.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryBtn(
                  onPressed: onSubmit,
                  width: 120,
                  height: 60,
                  text: "Yes",
                  textMaxSize: 35,
                  textMinSize: 30,
                  textColor: Colors.white,
                  color: StaticColors.greenColor,
                ),
                const SizedBox(width: 16),
                PrimaryBtn(
                    width: 120,
                    height: 60,
                    textMaxSize: 35,
                    textMinSize: 30,
                    textColor: Colors.white,
                    color: StaticColors.redColor,
                    onPressed: onCancle ??
                        () {
                          Get.back();
                        },
                    text: "No"),
              ],
            )
          ],
        ));
  }

  static animatedDialog(
      {required String title,
      double? width,
      double? height,
      bool isErr = false}) {
    return showDialog<void>(
      // Context
      barrierColor: Colors.transparent,
      context: Get.context!,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        ThemeData theme = Theme.of(context);
        return Center(
          child: SizedBox(
            height: height,
            width: width,
            child: Material(
              elevation: 3,
              // dialog color
              // shadowColor: ConfigController.to.isLightTheme
              //     ? Colors.black12
              //     : Colors.white,
              // backgraund color
              color: theme.cardColor,
              // border radius
              borderRadius: BorderRadius.circular(6),

              /// SpinningLines
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: Get.back,
                          splashFactory: NoSplash.splashFactory,
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context).colorScheme.surface,
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 60),
                        child: Column(
                          children: [
                            Lottie.asset(
                              'assets/animations/apiError.json',
                              height: 150,
                              repeat: true,
                              reverse: true,
                              fit: BoxFit.cover,
                            ),
                            // const SizedBox(height: 20),
                           
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // static permissionDialogWithAccessPin({
  //   required String title,
  //   required void Function() onSubmit,
  // }) {
  //   customDialog(
  //       width: 500,
  //       child: PermissionWithAccessPin(
  //         title: title,
  //         onSubmit: onSubmit,
  //       ));
  // }

  // close dialog
  static void closeLoadingDialog() {
    Get.back();
  }
}

