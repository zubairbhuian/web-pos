import 'package:flutter/material.dart';
import 'package:yogo_pos/app/modules/setting/widgets/menu_btn.dart';
import 'package:yogo_pos/app/services/controller/config_controller.dart';
import 'package:yogo_pos/app/utils/static_colors.dart';

import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: ConfigController.to.isLightTheme
                    ? theme.cardColor
                    : StaticColors.cartColor,
                title: GetBuilder<SettingController>(builder: (context) {
                  return Text(context.menuList[context.menuIndex].title);
                }),
                // backgroundColor: (ConfigController.to.isLightTheme
                //     ? theme.canvasColor
                //     : StaticColors.cartColor),
                centerTitle: true,
                // ! colour theme
                // actions: [
                //   Container(
                //     height: 45,
                //     width: 45,
                //     margin: const EdgeInsets.only(right: 12),
                //     decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         color: !ConfigController.to.isLightTheme
                //             ? Colors.black
                //             : Colors.white),
                //     child: CustomInkWell(
                //       onTap: ConfigController.to.toggleTheme,
                //       child: SvgPicture.asset(
                //         'assets/icons/theme.svg',
                //         // height: 55,
                //         colorFilter: ColorFilter.mode(
                //             ConfigController.to.isLightTheme
                //                 ? Colors.black
                //                 : Colors.white,
                //             BlendMode.srcIn),
                //       ),
                //     ),
                //   ),
                // ],
              ),
              body: Row(
                children: [
                  //menu
                  Container(
                    color: ConfigController.to.isLightTheme
                        ? theme.cardColor
                        : StaticColors.cartColor,
                    width: 300,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child:
                          GetBuilder<SettingController>(builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(controller.menuList.length,
                              (index) {
                            return MenuBtn(
                              icon: controller.menuList[index].icon,
                              title: controller.menuList[index].title,
                              isActive:
                                  controller.menuIndex == index ? true : false,
                              onTap: () {
                                controller.onChangeMenu(index);
                              },
                            );
                          }),
                        );
                      }),
                    ),
                  ),
                  // body
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(12),
                    color: ConfigController.to.isLightTheme
                        ? Colors.white
                        : const Color.fromARGB(255, 58, 58, 58),
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: GetBuilder<SettingController>(builder: (context) {
                        return controller.menuList[controller.menuIndex].child;
                      }),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
