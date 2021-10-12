import 'package:flutter/material.dart';
import 'package:google_maps/app/ui/global_controllers/session_controller.dart';
import 'package:google_maps/app/ui/pages/register/controller/register_controller.dart';
import 'package:google_maps/app/ui/pages/register/controller/register_state.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:google_maps/app/ui/global_widgets/custom_input_field.dart';
import 'package:google_maps/app/ui/global_widgets/rounded_button.dart';
import 'package:google_maps/app/ui/pages/register/utils/send_register_form.dart';
import 'package:google_maps/app/ui/utils/email_validator.dart';

final registerProvider = StateProvider<RegisterController, RegisterState>(
  (_) => RegisterController(sessionProvider.read),
);

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
    );
    final padding = context.mediaQueryPadding;
    final height = context.height - padding.top - padding.bottom - appBar.preferredSize.height;
    return ProviderListener<RegisterController>(
      provider: registerProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: appBar,
          body: ListView(
            children: [
              SizedBox(
                height: height,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      child: Form(
                        key: controller.registerFormKey,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 360,
                          ),
                          child: Column(
                            mainAxisAlignment:
                                context.isTablet ? MainAxisAlignment.center : MainAxisAlignment.end,
                            children: [
                              const Text(
                                "Registrarse",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              CustomInputField(
                                label: "Nombres",
                                onChanged: controller.onNameChanged,
                                validator: (text) {
                                  return text!.trim().length > 3 ? null : "invalid name";
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomInputField(
                                label: "E-mail",
                                inputType: TextInputType.emailAddress,
                                onChanged: controller.onEmailChanged,
                                validator: (text) {
                                  return isValidEmail(text!) ? null : "invalid email";
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomInputField(
                                label: "Password",
                                onChanged: controller.onPasswordChanged,
                                isPassword: true,
                                validator: (text) {
                                  if (text!.trim().length >= 6) {
                                    return null;
                                  }
                                  return "invalid password";
                                },
                              ),
                              const SizedBox(height: 15),
                              Consumer(
                                builder: (_, ref, __) {
                                  ref.watch(
                                    registerProvider.select(
                                      (_) => _.password,
                                    ),
                                  );
                                  return CustomInputField(
                                    label: "Confirmacion Password",
                                    onChanged: controller.onVPasswordChanged,
                                    isPassword: true,
                                    validator: (text) {
                                      if (controller.state.password != text) {
                                        return "password don't match";
                                      }
                                      if (text!.trim().length >= 6) {
                                        return null;
                                      }
                                      return "invalid password";
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 30),
                              RoundedButton(
                                backgroundColor: const Color.fromRGBO(136, 14, 79, 1),
                                text: "REGISTRO",
                                onPressed: () => sendRegisterForm(context),
                              ),
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
          ),
        );
      }
    );
  }
}