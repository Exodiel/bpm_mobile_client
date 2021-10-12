import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/domain/models/product.dart';
import 'package:google_maps/app/domain/repositories/product_repository.dart';
import 'package:google_maps/app/ui/global_controllers/cart_controller.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:google_maps/app/ui/routes/routes.dart';

class ProductsController extends SimpleNotifier {
  final ProductRepository _productRepository = Get.i.find();
  final CartController _cartController;

  ProductsController(this._cartController);

  Future<List<Product>> findProductsByCategory(int categoryId) {
    return _productRepository.findProductsByCategory(categoryId);
  }

  void addProduct(Product item) {
    _cartController.addToCart(item);
  }

  void removeProduct(Product item) {
    _cartController.removeFromCart(item);
  }

  Stream<List<Product>> get getCartStream => _cartController.streamController;

  List<Product> get getItems => _cartController.items;

  bool exists(int id) {
    return _cartController.productExistsInCart(id);
  }

  void goToCart() {
    router.pushNamed(
      Routes.CART,
    );
  }
}
