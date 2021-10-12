import 'package:flutter/material.dart';
import 'package:google_maps/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:google_maps/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:google_maps/app/ui/routes/routes.dart';
import 'package:flutter_meedu/router.dart' as router;
import '../login_page.dart' show loginProvider;

Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  // final isValidForm = controller.formKey.currentState!.validate();
  if (controller.email.isNotEmpty && controller.password.isNotEmpty) {
    ProgressDialog.show(context);
    final response = await controller.signIn();
    router.pop();
    if (response) {
      router.pushReplacementNamed(
        Routes.START,
      );
    } else {
      Dialogs.alert(
        context,
        title: "ERROR",
        content: "NO SE HA PODIDO INICIAR SESION",
      );
    }
  }
}
