import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/controllers/auth_controller.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/ui/widgets/custom_textfields.dart';
import 'package:flutter_new_structure/app/utils/constants/app_strings.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/getItHook/getit_hook.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends GetItHook<AuthController> {
  const ResetPasswordPage({super.key});

  static Future<T?>? route<T>() {
    return Get.offNamed(AppRoutes.resetPassword);
  }

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
