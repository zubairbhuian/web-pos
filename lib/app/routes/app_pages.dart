import 'package:get/get.dart';
import 'package:yogo_pos/app/modules/onlineOrder/bindings/online_order_binding.dart';
import 'package:yogo_pos/app/modules/onlineOrder/views/online_order_view.dart';

import '../middleware/router_welcome.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/signin_view.dart';

import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_IN;
  static final routes = [
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
        name: _Paths.SIGN_IN,
        page: () => const SigninView(),
        binding: AuthBinding(),
        middlewares: [RouteWlcomMiddleware()]),
    GetPage(
      name: _Paths.OLO,
      page: () => const OnlineOrderView(),
      binding: OnlineOrderBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
  ];
}
