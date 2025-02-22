import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/controllers/auth_controller.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/ui/widgets/custom_textfields.dart';
import 'package:flutter_new_structure/app/utils/constants/app_strings.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/getItHook/getit_hook.dart';
import 'package:flutter_new_structure/app/utils/helpers/validations/validations.dart';
import 'package:get/get.dart';

class RegisterPage extends GetItHook<AuthController> {
  const RegisterPage({super.key});

  static Future<T?>? route<T>() {
    return Get.toNamed(AppRoutes.register);
  }

  @override
  Widget build(BuildContext context) {
    final passObscure = true.obs;
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.T.register),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FormField(
                builder: (field) {
                  return Column(
                    children: [
                      const FlutterLogo(),
                      if (field.hasError && field.errorText != null) Text(field.errorText!),
                    ],
                  );
                },
                validator: (_) => AppValidations.imageValidation(null),
              ),
              TextInputField(
                type: InputType.name,
                controller: controller.nameController,
                hintLabel: AppStrings.T.nameLabel,
                validator: AppValidations.nameValidation,
              ),
              const SizedBox(height: 16),
              TextInputField(
                type: InputType.email,
                controller: controller.registerEmailController,
                hintLabel: AppStrings.T.emailLabel,
                validator: AppValidations.emailValidation,
              ),
              const SizedBox(height: 16),
              TextInputField(
                type: InputType.newPassword,
                controller: controller.registerPassController,
                hintLabel: AppStrings.T.passwordLabel,
                obscureText: passObscure,
                validator: AppValidations.passwordValidation,
              ),
              const SizedBox(height: 16),
              TextInputField(
                type: InputType.phoneNumber,
                controller: controller.phoneNumberController,
                hintLabel: AppStrings.T.phoneNumberLabel,
                validator: AppValidations.phoneNumberValidation,
              ),
              const SizedBox(height: 16),
              Obx(
                () => controller.registerState.isLoading
                    ? const CircularProgressIndicator()
                    : Builder(
                        builder: (context) {
                          return ElevatedButton(
                            onPressed: () => controller.sendOtp(context),
                            child: Text(AppStrings.T.register),
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
      ..nameController.clear()
      ..registerEmailController.clear()
      ..registerPassController.clear()
      ..phoneNumberController.clear();
  }

  @override
  void onDispose() {}
}
