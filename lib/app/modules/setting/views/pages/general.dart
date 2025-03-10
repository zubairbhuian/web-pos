import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yogo_pos/app/modules/setting/controllers/general_controller.dart';
import 'package:yogo_pos/app/modules/setting/controllers/setting_controller.dart';
import 'package:yogo_pos/app/services/controller/config_controller.dart';
import 'package:yogo_pos/app/utils/int_extensions.dart';
import 'package:yogo_pos/app/utils/static_colors.dart';
import 'package:yogo_pos/app/widgets/custom_btn.dart';

class General extends StatelessWidget {
  const General({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "App Sound",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: ConfigController.to.isLightTheme
                    ? theme.cardColor
                    : Colors.white.withOpacity(.2),
              ),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: ConfigController.to.isLightTheme
                      ? theme.cardColor
                      : Colors.white.withOpacity(.2),
                ))),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Notification Sound',
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<GeneralController>(builder: (context) {
                      return Switch(
                          value: context.isNotificationSound,
                          onChanged: context.onChangeNotificationSound);
                    })
                  ],
                ),
              ),
              //       // Container(
              //       //   padding:
              //       //       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //       //   child: Row(
              //       //     children: [
              //       //       Expanded(
              //       //         child: Row(
              //       //           children: [
              //       //             Text(
              //       //               'Line 2 ',
              //       //               style: theme.textTheme.titleSmall,
              //       //             ),

              //       //           ],
              //       //         ),
              //       //       ),
              //       //       GetBuilder<GeneralController>(builder: (context) {
              //       //         return Switch(
              //       //             value: context.telePhoneL2,
              //       //             onChanged: context.onChangeL2);
              //       //       })
              //       //     ],
              //       //   ),
              //       // )
            ],
          ),
        ),
        30.height,
        // Custom Keyboard
        Text(
          "Custom Keyboard",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: ConfigController.to.isLightTheme
                    ? theme.cardColor
                    : Colors.white.withOpacity(.2),
              ),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: ConfigController.to.isLightTheme
                      ? theme.cardColor
                      : Colors.white.withOpacity(.2),
                ))),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Custom Keyboard',
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<GeneralController>(builder: (context) {
                      return Switch(
                          value: context.isCustomKeyboard,
                          onChanged: context.onChangeCustomKeyboard);
                    })
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Keyboard Sound',
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<GeneralController>(builder: (context) {
                      return Switch(
                          value: context.isKeyboardSound,
                          onChanged: context.onChangeKeyboardSound);
                    })
                  ],
                ),
              )
            ],
          ),
        ),
        30.height,
        Row(
          children: [
            // const SizedBox(width: 10),
            PrimaryBtnWithChild(
                height: 50,
                width: 140,
                color: StaticColors.orangeColor,
                onPressed: SettingController.to.restartApp,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restart_alt_sharp, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Restart')
                  ],
                )),
          ],
        )
      ],
    );
  }
}
