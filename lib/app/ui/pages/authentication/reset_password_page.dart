import 'package:demo/app/controllers/auth_controller.dart';
import 'package:demo/app/ui/widgets/custom_textfields.dart';
import 'package:demo/app/utils/constants/app_strings.dart';
import 'package:demo/app/utils/helpers/exception/exception.dart';
import 'package:demo/app/utils/helpers/getItHook/getit_hook.dart';
import 'package:demo/app/utils/helpers/validations/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends GetItHook<AuthController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final passObscure = true.obs;
    final confirmPassObscure = true.obs;
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.T.resetPassword),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(
                () => TextInputField(
                  type: InputType.newPassword,
                  controller: controller.resetPassController,
                  hintLabel: AppStrings.T.newPasswordLabel,
                  obscureText: passObscure,
                  validator: AppValidations.passwordValidation,
                ),
              ),
              Obx(
                () => TextInputField(
                  type: InputType.confirmPassword,
                  controller: controller.confirmPassController,
                  validator: (value) => AppValidations.confirmPasswordValidation(value, controller.passController.text),
                  hintLabel: AppStrings.T.confirmPasswordLabel,
                  obscureText: confirmPassObscure,
                ),
              ),
              Obx(
                () => controller.resetPassState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: () => controller.resetPassword(context),
                            child: Text(AppStrings.T.resetPassword),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get canDisposeController => false;

  @override
  void onInit() {
    controller
      ..resetPassController.clear()
      ..confirmPassController.clear();
  }

  @override
  void onDispose() {}
}
