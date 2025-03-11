import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:toastification/toastification.dart';
import 'package:yogo_pos/app/modules/onlineOrder/controllers/online_order_controller.dart';
import 'package:yogo_pos/app/modules/onlineOrder/models/order_model.dart';
import 'package:yogo_pos/app/modules/onlineOrder/repo/online_order_repo.dart';

import 'package:yogo_pos/app/services/base/preferences.dart';
import 'package:yogo_pos/app/services/controller/base_controller.dart';
import 'package:yogo_pos/app/utils/logger.dart';
import 'package:yogo_pos/app/utils/urls.dart';
import 'package:yogo_pos/app/widgets/popup_dialogs.dart';


// class SocketController extends GetxController {
//   IO.Socket? _socket;
//   bool _isManualDisconnect = false; // Flag to track manual disconnection
//   int _reconnectAttempts = 0; // Track reconnect attempts
//   final int _maxReconnectAttempts = 5; // Maximum reconnect attempts
//   final Duration _reconnectDelay =
//       const Duration(seconds: 5); // Delay between reconnects

//   void connect() {
//     _isManualDisconnect = false; // Reset manual disconnect flag
//     _reconnectAttempts = 0; // Reset reconnect attempts

//     _socket = IO.io(URLS.socketServer, <String, dynamic>{
//       "transports": ["websocket"],
//       "autoConnect": false, // Manually handle connection
//       "timeout": 4000,
//     });

//     _socket!.connect();

//     _socket!.onConnect((_) {
//       kLogger.i("✅ Connected to Socket.IO Server");
//       _reconnectAttempts =
//           0; // Reset reconnect attempts on successful connection
//     });
//     _socket?.emit("register", "${BaseController.to.restaurantDetails?.id}");

//     _socket!.onDisconnect((_) {
//       kLogger.e("❌ Disconnected from Server");
//       if (!_isManualDisconnect) {
//         _attemptReconnect(); // Attempt to reconnect if not manually disconnected
//       }
//     });

//     _socket!.onError((_) {
//       kLogger.e("Error: $_");
//       if (!_isManualDisconnect) {
//         _attemptReconnect(); // Attempt to reconnect on error
//       }
//     });

//     _socket!.on("onlineOrderPlaced", (data) {
//       kLogger.i("Online Order Placed: $data");
//       try {
//         OrderModel order = OrderModel.fromJson(data);
//         toastification.show(
//           title: const Text("Online Order Received", maxLines: 1),
//           description: Text(
//             "Order #${order.orderId} - Amount: \$${order.totalOrderAmount.toStringAsFixed(2)}",
//             maxLines: 4,
//           ),
//           type: ToastificationType.info,
//           autoCloseDuration: const Duration(seconds: 5),
//         );
//         if (PrintersController.to.oloPrint.value) {
//           OnlineOrderRepo.onOnlinePrint(order);
//         }
//         OnlineOrderController.to.getOrders();
//       } catch (e) {
//         PopupDialog.showErrorMessage("OLO data format is not correct");
//         kLogger.e('Error from %%%% oline order data format %%%% => $e');
//       }
//     });
//   }

//   void disconnect() {
//     _isManualDisconnect = true; // Set manual disconnect flag
//     _socket?.disconnect();
//     kLogger.i("🛑 Manually disconnected from Socket.IO Server");
//   }

//   void _attemptReconnect() {
//     if (_reconnectAttempts < _maxReconnectAttempts) {
//       _reconnectAttempts++;
//       kLogger.i(
//           "🔁 Attempting to reconnect (Attempt $_reconnectAttempts/$_maxReconnectAttempts)...");
//       Future.delayed(_reconnectDelay, () {
//         connect(); // Retry connection after delay
//       });
//     } else {
//       kLogger.e("🚫 Max reconnect attempts reached. Giving up.");
//     }
//   }

//   @override
//   void onClose() {
//     disconnect(); // Disconnect socket when controller is closed
//     super.onClose();
//   }

//   @override
//   void onInit() {
//     connect(); // Connect socket when controller is initialized
//     super.onInit();
//   }
// }
class SocketController extends GetxController {
  IO.Socket? _socket;

  void connect() {
    _socket = IO.io(URLS.socketServer, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      // "timeout": 20000,
    });

    _socket!.connect();

    _socket!.onConnect((_) {
      BaseController.to.onChangeSocketConnection(true);
      kLogger.i("✅ Connected to Socket.IO Server");
    });
    _socket?.emit("register", "${BaseController.to.restaurantDetails?.id}");
    // _socket!.on("message", (data) {
    //   kLogger.i("📩 Received: $data");
    // });
    _socket!.on("onlineOrderPlaced", (data) {
      kLogger.i("Online Order Placed: $data");
      try {
        // order
        OrderModel order = OrderModel.fromJson(data);
        // Notification Sound
        if (Preferences.isNotificationSound) {
          BaseController.to.playNotificationSound();
        }

        //show dialog

        toastification.show(
          title: const Text(
            "Online Order Received",
            maxLines: 1,
          ),
          description: Text(
            "Order #${order.orderId} - Amount: \$${order.totalOrderAmount.toStringAsFixed(2)}",
            maxLines: 4,
          ),
          type: ToastificationType.info,
          autoCloseDuration: const Duration(seconds: 5),
        );
        // get olo order
        OnlineOrderController.to.getOrders();
      } catch (e) {
        PopupDialog.showErrorMessage("OLO data format is not correct");
        kLogger.e('Error from %%%% oline order data format %%%% => $e');
      }
    });

    _socket!.onDisconnect((_) {
      BaseController.to.onChangeSocketConnection(false);
      kLogger.e("❌ Disconnected from Server");
    });
    _socket!.onError((_) {
      BaseController.to.onChangeSocketConnection(false);
      kLogger.e("Error: $_");
    });
  }

  void disconnect() {
    _socket?.disconnect();
    // kLogger.i("disconnect");
  }

  @override
  void onClose() {
    _socket?.disconnect();
    super.onClose();
  }

  @override
  void onInit() {
    connect();
    super.onInit();
  }
}
