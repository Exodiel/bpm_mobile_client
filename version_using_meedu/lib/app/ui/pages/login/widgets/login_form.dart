import 'package:flutter/material.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps/app/ui/global_widgets/custom_input_field.dart';
import 'package:google_maps/app/ui/global_widgets/rounded_button.dart';
import 'package:google_maps/app/ui/pages/login/login_page.dart';
import 'package:google_maps/app/ui/pages/login/utils/send_login_form.dart';
import 'package:google_maps/app/ui/routes/routes.dart';
import 'package:google_maps/app/ui/utils/colors.dart';
import 'package:google_maps/app/ui/utils/email_validator.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final _controller = loginProvider.read;

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).size;
    // MediaQuery.of(context).padding.bottom;
    final padding = context.mediaQueryPadding;
    final height = context.height - padding.top - padding.bottom;
    return ListView(
      children: [
        SizedBox(
          height: height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Form(
                // key: _controller.formKey,
                child: Align(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 360,
                    ),
                    child: Column(
                      mainAxisAlignment:
                          context.isTablet ? MainAxisAlignment.center : MainAxisAlignment.end,
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: SvgPicture.asset(
                            'assets/images/welcome.svg',
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomInputField(
                          label: "Email",
                          onChanged: _controller.onEmailChanged,
                          inputType: TextInputType.emailAddress,
                          validator: (text) {
                            if (isValidEmail(text!)) {
                              return null;
                            }
                            return "Invalid email";
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomInputField(
                          label: "Password",
                          onChanged: _controller.onPasswordChanged,
                          isPassword: true,
                          validator: (text) {
                            if (text!.trim().length >= 6) {
                              return null;
                            }
                            return "Invalid password";
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RoundedButton(
                              backgroundColor: swatch[900],
                              text: "Ingresar",
                              onPressed: () => sendLoginForm(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "¿No tienes cuenta?",
                            ),
                            TextButton(
                              onPressed: () => router.pushNamed(
                                Routes.REGISTER,
                              ),
                              child: const Text(
                                "Registrate",
                                style: TextStyle(
                                  color: Color.fromRGBO(136, 14, 79, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        if (!context.isTablet) const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}