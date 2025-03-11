import 'package:get/get.dart';

import '../controllers/online_order_controller.dart';
import '../controllers/socket_controller.dart';

class OnlineOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlineOrderController>(
      () => OnlineOrderController(),
    );
    Get.lazyPut<SocketController>(
      () => SocketController(),
    );
  }
}
