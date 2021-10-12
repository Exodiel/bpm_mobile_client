import 'package:flutter/material.dart';
import 'package:google_maps/app/ui/pages/checkout/widgets/dropdown_widget.dart';
import 'package:google_maps/app/ui/pages/checkout/widgets/input.dart';
import '../checkout_page.dart' show checkoutProvider;


class Inputs extends StatelessWidget {
  const Inputs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = checkoutProvider.read;
    return Column(
      children: [
        // Input(
        //   controller: controller.description,
        //   focusNode: controller.descriptionFocusNode,
        //   placeholder: 'Descripcion',
        //   onChanged: controller.onQueryChanged,
        //   onClear: controller.clearQuery,
        // ),
        PaymenWidget(controller: controller.payment)
      ],
    );
  }
}