import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/helpers/exception/exception.dart';
import '../../../utils/helpers/injectable/injectable.dart';
import '../../widgets/custom_textfields.dart';

class ResetPasswordPage extends StatelessWidget {
  final AuthController _authController = getIt<AuthController>();

  ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var passObscure = true.obs;
    var confirmPassObscure = true.obs;
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.T.resetPassword),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Obx(
                () => TextInputField(
                  type: InputType.newPassword,
                  controller: _authController.resetPassController,
                  hintLabel: AppStrings.T.newPasswordLabel,
                  obscureText: passObscure,
                  validator: AppValidations.passwordValidation,
                ),
              ),
              Obx(
                () => TextInputField(
                  type: InputType.confirmPassword,
                  controller: _authController.confirmPassController,
                  validator: (value) => AppValidations.confirmPasswordValidation(value, _authController.passController.text),
                  hintLabel: AppStrings.T.confirmPasswordLabel,
                  obscureText: confirmPassObscure,
                ),
              ),
              Obx(
                () => _authController.resetPassState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(builder: (context) {
                        return ElevatedButton(
                          onPressed: () => _authController.resetPassword(context),
                          child: Text(AppStrings.T.resetPassword),
                        );
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
