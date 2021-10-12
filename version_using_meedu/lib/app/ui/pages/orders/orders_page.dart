import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:google_maps/app/ui/pages/orders/controller/orders_controller.dart';
import 'package:google_maps/app/ui/pages/orders/widgets/orders_widget.dart';

final ordersProvider = SimpleProvider(
  (_) => OrdersController(),
);

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<OrdersController>(
      provider: ordersProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Pedidos'
            ),
          ),
          body: OrdersWidget(),
        );
      },
    );
  }
}