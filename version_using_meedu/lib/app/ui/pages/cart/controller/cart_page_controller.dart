import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/domain/models/product.dart';
import 'package:google_maps/app/ui/global_controllers/cart_controller.dart';
import 'package:google_maps/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;

class CartPageController extends SimpleNotifier {
  final CartController _cartController;

  CartPageController(this._cartController);

  Stream<List<Product>> get getCartStream => _cartController.streamController;

  List<Product> get getItems => _cartController.items;

  double get subtotal => _cartController.subtotal;

  double get tax => _cartController.tax;

  double get total => _cartController.total;

  void recalculate(Product item) {
    _cartController.recalculate(item);
  }

  void goToCheckout() {
    router.pushNamed(
      Routes.CHECKOUT,
    );
  }
}