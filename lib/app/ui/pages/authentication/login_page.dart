import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/app_messages.dart';
import '../../../utils/helpers/injectable/injectable.dart';
import '../../widgets/custom_textfields.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = getIt<AuthController>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var passObscure = true.obs;
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppMessages.loginPageTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextInputField(
                  type: InputType.text,
                  controller: _authController.emailController,
                  hintLabel: AppMessages.emailLabel,
                  validator: AppValidations.emailValidation,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextInputField(
                    type: InputType.password,
                    controller: _authController.passController,
                    hintLabel: AppMessages.passwordLabel,
                    obscureText: passObscure,
                    textInputAction: TextInputAction.done,
                    validator: AppValidations.passwordValidation,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => _authController.loginState.isLoading
                      ? const CircularProgressIndicator()
                      : Builder(
                          builder: (context) {
                            return ElevatedButton(
                              onPressed: () => _authController.login(context),
                              child: const Text(AppMessages.loginButton),
                            );
                          },
                        ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.register),
                  child: const Text(AppMessages.registerRedirect),
                ),
                TextButton(
                  onPressed: () {
                    _authController
                      ..forgotEmailController.clear()
                      ..resetPassController.clear()
                      ..confirmPassController.clear();
                    Get.toNamed(AppRoutes.forgotPassword);
                  },
                  child: const Text(AppMessages.forgotPasswordRedirect),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.theme),
                  child: const Text(AppMessages.theme),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
