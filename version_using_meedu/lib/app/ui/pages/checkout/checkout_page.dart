import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/ui/pages/checkout/controller/checkout_controller.dart';
import 'package:google_maps/app/ui/global_controllers/cart_controller.dart'
    show cartProvider;
import 'package:google_maps/app/ui/global_controllers/session_controller.dart'
    show sessionProvider;
import 'package:google_maps/app/ui/pages/checkout/widgets/address_widget.dart';
import 'package:google_maps/app/ui/pages/checkout/widgets/checkout_widget.dart';
import 'package:google_maps/app/ui/pages/checkout/widgets/dropdown_widget.dart';
import 'package:google_maps/app/ui/pages/checkout/widgets/inputs.dart';
import 'package:google_maps/app/ui/pages/home/utils/go_to_search.dart';

final checkoutProvider = SimpleProvider(
  (_) => CheckoutController(cartProvider.read, sessionProvider.read),
);

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<CheckoutController>(
      provider: checkoutProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Pedido'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Productos',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckoutWidget(),
                const Text(
                  'Direccion',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                AddressWidget(),
                const Text(
                  'Forma de pago',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Inputs(),
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () => controller.saveOrder(context),
            child: Container(
              height: 56,
              margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                child: const Text(
                  'REALIZAR MI PEDIDO',
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
