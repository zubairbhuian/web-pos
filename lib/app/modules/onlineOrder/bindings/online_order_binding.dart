import 'package:get/get.dart';

import '../controllers/online_order_controller.dart';
import '../controllers/socket_controller.dart';

class OnlineOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnlineOrderController>(OnlineOrderController());
    Get.put<SocketController>(SocketController());
  }
}
