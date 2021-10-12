import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/app/domain/models/product.dart';
import '../start_page.dart' show startProvider;

class CartWidget extends StatelessWidget {
  CartWidget({Key? key}) : super(key: key);

  final _controller = startProvider.read;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.getCartStream,
      initialData: _controller.getItems,
      builder: (_, AsyncSnapshot<List<Product>?> snapshot) {
        if (snapshot.hasData) {
          final cart = snapshot.data;
          if (cart != null) {
            return GestureDetector(
              onTap: () {
                _controller.goToCart();
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
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          );
        }
        return IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart),
        );
      },
    );
  }
}
