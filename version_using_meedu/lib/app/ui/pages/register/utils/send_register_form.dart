import 'package:flutter/material.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:google_maps/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:google_maps/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:google_maps/app/ui/routes/routes.dart';
import '../register_page.dart' show registerProvider;

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.registerFormKey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();

    if (!response) {
      Dialogs.alert(
        context,
        title: "ERROR",
        content: "NO SE HA PODIDO REGISTRAR EL USUARIO",
      );
    } else {
      router.pushNamedAndRemoveUntil(
        Routes.HOME,
      );
    }
  }else {
    Dialogs.alert(
      context,
      title: "ERROR",
      content: "CAMPOS INCORRECTOS",
    );
  }
}
