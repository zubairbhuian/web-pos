import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:yogo_pos/app/services/base/preferences.dart';
import 'package:yogo_pos/app/services/controller/base_controller.dart';
import 'package:yogo_pos/app/utils/int_extensions.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(builder: (controller) {
      return Container(
        height: 30,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            20.width,
            //left
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // notification sound
                Visibility(
                  visible: Preferences.isNotificationSound,
                  replacement: const Icon(
                    Icons.notifications_off_outlined,
                    color: Colors.black,
                    size: 16,
                  ),
                  child: const Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
                // socket connection
                Visibility(
                  visible: controller.isSocketConnected,
                  replacement: Lottie.asset(
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                          "assets/animations/connection_error.json")
                      .marginOnly(left: 3),
                  child: Lottie.asset(
                      // width: 35,
                      // height: 35,
                      fit: BoxFit.cover,
                      "assets/animations/connection_stable.json"),
                ),
                // // for internet connection
                // const Icon(
                //   Icons.wifi,
                //   color: Colors.black,N
                //   size: 16,
                // ),
                // 10.width,
                // const Icon(
                //   Icons.connect_without_contact_sharp,
                //   size: 16,
                //   color: Colors.black,
                // ),
              ],
            )),
          ],
        ),
      );
    });
  }
}
