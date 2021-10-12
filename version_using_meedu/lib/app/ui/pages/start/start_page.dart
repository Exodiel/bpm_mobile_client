import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps/app/ui/global_controllers/session_controller.dart'
    show sessionProvider;
import 'package:google_maps/app/ui/global_controllers/cart_controller.dart'
    show cartProvider;
import 'package:google_maps/app/ui/pages/start/controller/start_controller.dart';
import 'package:google_maps/app/ui/pages/start/widgets/cart_widget.dart';
import 'package:google_maps/app/ui/pages/start/widgets/categories_widget.dart';

final startProvider = SimpleProvider(
  (_) => StartController(sessionProvider.read, cartProvider.read),
);

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderListener<StartController>(
      provider: startProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Inicio"),
            actions: [
              CartWidget(),
              IconButton(
                onPressed: () => controller.logOut(context),
                icon: const Icon(Icons.exit_to_app_outlined),
              ),
            ],
          ),
          body: const CategoriesWidget(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => controller.goToOrders(),
            child: const FaIcon(FontAwesomeIcons.solidListAlt),
          ),
        );
      },
    );
  }
}
