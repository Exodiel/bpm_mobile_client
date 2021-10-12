import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/domain/models/order.dart';
import 'package:google_maps/app/domain/models/place.dart';
import 'package:google_maps/app/domain/models/product.dart';
import 'package:google_maps/app/domain/repositories/detail_repository.dart';
import 'package:google_maps/app/domain/repositories/order_repository.dart';
import 'package:google_maps/app/ui/global_controllers/cart_controller.dart';
import 'package:google_maps/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:google_maps/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:google_maps/app/ui/routes/routes.dart';

class CheckoutController extends SimpleNotifier {
  final CartController _cartController;
  final SessionController _sessionController;
  final OrderRepository _orderRepository = Get.i.find();
  final DetailRepository _detailRepository = Get.i.find();

  CheckoutController(this._cartController, this._sessionController);

  Stream<List<Product>> get getCartStream => _cartController.streamController;

  List<Product> get getItems => _cartController.items;

  double get subtotal => _cartController.subtotal;

  double get tax => _cartController.tax;

  double get total => _cartController.total;

  Place? get origin => _sessionController.origin;

  Place? get destination => _sessionController.destination;

  final description = TextEditingController();
  final payment = TextEditingController();

  final descriptionFocusNode = FocusNode();
  final paymentFocusNode = FocusNode();

  late bool _descriptionHasFocus;
  bool get descriptionHasFocus => _descriptionHasFocus;

  String _text = '';
  String get text => _text;

  void onQueryChanged(String text) {
    _text = text;
    description.text = text;
  }

  void clearQuery() {
    _text = '';
    description.text = '';
    notify();
  }

  void goToHome() {
    router.pushNamed(
      Routes.HOME,
    );
  }

  Future<void> saveOrder(BuildContext context) async {
    final map = {
      'origin': {
        'latitude': _sessionController.origin!.position.latitude,
        'longitude': _sessionController.origin!.position.longitude,
      },
      'destination': {
        'latitude': _sessionController.destination!.position.latitude,
        'longitude': _sessionController.destination!.position.longitude,
      }
    };
    DateTime dateToday = DateTime.now();
    String date = dateToday.toString().substring(0, 10);
    ProgressDialog.show(context);
    final order = Order(
      address: map.toString(),
      id: 1,
      description: 'PEDIDO DESDE LA APP',
      subtotal: double.parse(_cartController.subtotal.toStringAsFixed(2)),
      tax: double.parse(_cartController.tax.toStringAsFixed(2)),
      total: double.parse(_cartController.total.toStringAsFixed(2)),
      createdAt: '',
      updatedAt: '',
      type: 'Venta',
      origin: 'mobile',
      state: 'creado',
      sequential: '',
      payment: payment.value.text,
      date: date,
    );
    final data = await _orderRepository.save(order);

    final List<Map<String, dynamic>> detailsJson = [];
    for (var element in _cartController.items) {
      detailsJson.add({
        'quantity': element.quantity,
        'price': double.parse(element.price),
        'subtotal': element.subtotal,
        'productId': element.id,
        'discount': 0,
        'discountvalue': 0,
        'orderId': data.id
      });
    }
    await _detailRepository.saveDetails(detailsJson);
    _cartController.clearCart();
    router.pop();
    router.pushNamedAndRemoveUntil(
      Routes.START,
    );
  }
}
