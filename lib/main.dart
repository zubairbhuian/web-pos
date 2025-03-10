import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:yogo_pos/app/services/controller/base_controller.dart';
import 'package:yogo_pos/app/services/controller/config_controller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:yogo_pos/config/dark_theme.dart';
import 'package:yogo_pos/config/light_theme.dart';
import 'package:get/get.dart';
import 'app/services/base/api_service.dart';
import 'app/services/base/dio_interceptor.dart';
import 'app/services/base/preferences.dart';
import 'app/services/bindings/base_binding.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  //hive init

  // init hive and adapters
  tz.initializeTimeZones();
 
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// Shared Preferences
  await Preferences.init();

  /// Initialize the dio
  final dio = Dio();

  // Initialize the dio instance
  dio.interceptors.add(DioInterceptor());

  /// Add the dio instance to the api service
  final apiService = ApiService(dio: dio);
  Get.put(BaseController(apiService: apiService), permanent: true);
  Get.put(ConfigController(), permanent: true);

  /// Add the dio instance to the bindings
  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  const MyApp({
    super.key,
    required this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            BaseController.to.resetInactivityTimer(), // Reset timer on any tap
        onPanDown: (_) => BaseController.to
            .resetInactivityTimer(), // Reset timer on drag/scroll start
        child: MouseRegion(
          onHover: (_) => BaseController.to
              .resetInactivityTimer(), // Reset timer on mouse hover
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              BaseController.to
                  .resetInactivityTimer(); // Reset timer on any scroll event
              return true;
            },
            child: ToastificationWrapper(
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'web pos',
                themeMode: ConfigController.to.isLightTheme
                    ? ThemeMode.light
                    : ThemeMode.dark,
                theme: lightTheme,
                darkTheme: darkTheme,
                initialBinding: BaseBinding(apiService: apiService),
                initialRoute: AppPages.INITIAL,
                // initialRoute: Routes.TABLE_RESERVATIONS,
                // initialRoute: Routes.ONLINE_ORDER,
                getPages: AppPages.routes,
              ),
            ),
          ),
        ));
  }
}
