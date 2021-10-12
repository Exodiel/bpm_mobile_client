import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/domain/models/product.dart';
import 'package:google_maps/app/ui/pages/products/controller/products_controller.dart';
import 'package:google_maps/app/ui/pages/products/widgets/products_widget.dart';
import 'package:google_maps/app/ui/global_controllers/cart_controller.dart'
    show cartProvider;
import 'package:badges/badges.dart';

final productsProvider = SimpleProvider(
  (_) => ProductsController(cartProvider.read),
);

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    return ProviderListener<ProductsController>(
      provider: productsProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Productos'),
            actions: [
              StreamBuilder(
                stream: controller.getCartStream,
                initialData: controller.getItems,
                builder: (_, AsyncSnapshot<List<Product>?> snapshot) {
                  if (snapshot.hasData) {
                    final cart = snapshot.data;
                    if (cart != null) {
                      return GestureDetector(
                        onTap: () {
                          controller.goToCart();
                        },
                        child: Badge(
                          showBadge: cart.isNotEmpty,
                          position: BadgePosition.topEnd(top: -2),
                          badgeContent: Text(
                            "${cart.length}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                          ),
                          animationType: BadgeAnimationType.scale,
                        ),
                      );
                    }
                    return IconButton(
                      onPressed: () {
                        controller.goToCart();
                      },
                      icon: const Icon(Icons.shopping_cart),
                    );
                  }
                  return IconButton(
                    onPressed: () {
                      controller.goToCart();
                    },
                    icon: const Icon(Icons.shopping_cart),
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          body: ProductsWidget(categoryId: args),
        );
      },
    );
  }
}
