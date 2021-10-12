import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/ui/pages/cart/controller/cart_page_controller.dart';
import 'package:google_maps/app/ui/global_controllers/cart_controller.dart'
    show cartProvider;
import 'package:google_maps/app/ui/pages/cart/widgets/cart_page_widget.dart';
import 'package:google_maps/app/ui/pages/cart/widgets/totals_widget.dart';

final cartPageProvider = SimpleProvider(
  (_) => CartPageController(cartProvider.read),
);

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<CartPageController>(
      provider: cartPageProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Carrito'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: controller.getItems.isNotEmpty
                ? Column(
                    children: [
                      CartPageWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      TotalsWidget(),
                    ],
                  )
                : const Center(
                    child: Text(
                      'No existen productos disponibles',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () => controller.goToCheckout(),
            child: Container(
              height: 56,
              margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                child: const Text(
                  "PEDIR AHORA",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
