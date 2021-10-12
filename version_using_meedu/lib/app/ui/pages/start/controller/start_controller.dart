import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:google_maps/app/domain/models/category.dart';
import 'package:google_maps/app/domain/models/order.dart';
import 'package:google_maps/app/domain/models/product.dart';
import 'package:google_maps/app/domain/repositories/category_repository.dart';
import 'package:google_maps/app/ui/global_controllers/awesome_notification_controller.dart';
import 'package:google_maps/app/ui/global_controllers/cart_controller.dart';
import 'package:google_maps/app/ui/global_controllers/session_controller.dart';
import 'package:google_maps/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:google_maps/app/ui/routes/routes.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:google_maps/app/utils/platform.dart' show isIOS;

class StartController extends SimpleNotifier {
  final SessionController _sessionController;
  final CartController _cartController;
  final CategoryRepository _categoryRepository = Get.i.find();
  late io.Socket socket;

  StartController(this._sessionController, this._cartController);

  Future<void> logOut(BuildContext context) async {
    ProgressDialog.show(context);
    await _sessionController.signOut();
    router.pop();
    router.pushReplacementNamed(Routes.LOGIN);
  }

  void goToProducts(int categoryId) {
    router.pushNamed(Routes.PRODUCTS, arguments: categoryId);
  }

  void goToCart() {
    router.pushNamed(
      Routes.CART,
    );
  }

  void goToOrders() {
    router.pushNamed(
      Routes.ORDERS,
    );
  }

  Future<List<Category>> find() async => await _categoryRepository.find();

  Stream<List<Product>> get getCartStream => _cartController.streamController;

  List<Product> get getItems => _cartController.items;

  late StreamSubscription<ReceivedNotification> _subscription;

  void initializeNotifications(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then(
                        (_) => Navigator.pop(context),
                      ),
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
    _subscription = AwesomeNotifications().createdStream.listen(
      (notification) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Notification Created on ${notification.channelKey}',
            ),
          ),
        );
      },
    );

    AwesomeNotifications().actionStream.listen(
      (notification) {
        if (notification.channelKey == 'basic_channel' && isIOS) {
          AwesomeNotifications().getGlobalBadgeCounter().then(
                (value) => AwesomeNotifications().setGlobalBadgeCounter(
                  value - 1,
                ),
              );
        }
      },
    );
  }

  void connect() {
    socket = io.io('http://192.168.0.103:8000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.onConnect((data) => print('onConnect'));
    socket.on('status-updated', (data) async {
      final order = Orders.fromJson(data);
      final userId = await _sessionController.userId;

      if (order.person!.id == int.parse(userId!)) {
        await createNotificationOnEvent(
          "Tu pedido se encuentra en: ${order.state}",
          "Pedido #${order.sequential}",
        );
      }
    });
    socket.on('disconnection', (_) => print('disconnect'));
    print("connected: ${socket.connected}");
  }

  void close() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    _subscription.cancel();
    socket.disconnect();
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }
}
